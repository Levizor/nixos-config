{ self, ... }:
{

  perSystem =
    { pkgs, ... }:
    let
      wl = "${pkgs.wl-clipboard}/bin";
      xl = "${pkgs.xclip}/bin";
    in
    {
      packages = {
        clip-copy = pkgs.writeShellScriptBin "clip-copy" ''
          # 1. Wayland  → wl-copy
          # 2. X11      → xclip
          # 3. SSH/TTY  → OSC 52 (Kitty, WezTerm, tmux w/ set-clipboard on)
          if [ -n "$WAYLAND_DISPLAY" ]; then
            exec ${wl}/wl-copy
          elif [ -n "$DISPLAY" ]; then
            exec ${xl}/xclip -selection clipboard
          else
            printf '\033]52;c;%s\a' "$(base64 | tr -d '\n')"
          fi
        '';

        clip-paste = pkgs.writeShellScriptBin "clip-paste" ''
          if [ -n "$WAYLAND_DISPLAY" ]; then
            exec ${wl}/wl-paste --no-newline
          elif [ -n "$DISPLAY" ]; then
            exec ${xl}/xclip -selection clipboard -out
          else
            echo "clip-paste: no display server (Wayland/X11 required)" >&2
            exit 1
          fi
        '';
      };
    };

  flake.homeModules.clipboard =
    { pkgs, system, ... }:
    {
      home.packages = [
        self.packages.${system}.clip-copy
        self.packages.${system}.clip-paste
      ];
    };
}
