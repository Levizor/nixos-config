{ self, ... }:
{
  flake.homeModules.zsh =
    {
      config,
      pkgs,
      lib,
      myopts,
      system,
      ...
    }:
    let
      copy = lib.getExe self.packages.${system}.clip-copy;
      paste = lib.getExe self.packages.${system}.clip-paste;
    in
    {
      imports = [
        self.homeModules.oh-my-posh
        self.homeModules.shell-aliases
        self.homeModules.zoxide
      ];
      programs.fzf.enable = true;
      programs.zsh = {
        enable = true;
        dotDir = "${config.home.homeDirectory}/.zsh";

        plugins = [
          {
            # Must be before plugins that wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
            name = "fzf-tab";
            src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
          }
        ];

        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;

        initContent = lib.concatStringsSep "\n" [
          (builtins.readFile ./init.zsh)
          (builtins.readFile ./functions.zsh)
          (''
            ztree() {
                [[ -f "$1" ]] || { echo "Usage: ztree <archive.zip>"; return 1; }
                unzip -Z1 "$1" | ${lib.getExe pkgs.tree} --fromfile
            }
          '')
          (lib.optionalString (!myopts.server) ''
            #tmux
            zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
            zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0

            # apply to all command
            zstyle ':fzf-tab:*' popup-min-size 50 8
            # only apply to 'diff'
            zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12
          '')
          # Override OMZ's clipcopy/clippaste with our universal wrappers.
          # This makes copypath, copyfile, copybuffer OMZ plugins all use
          # clip-copy, which includes OSC 52 fallback for SSH sessions.
          ''
            clipcopy()  { ${copy}  }
            clippaste() { ${paste} }
          ''
        ];

        history = {
          size = 100000;
          path = "${config.programs.zsh.dotDir}/.zsh/history";
        };

        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "sudo"
            "colored-man-pages"
            "copybuffer"
            "extract"
            "cp"
            "magic-enter"
          ];
        };

        antidote = {
          enable = true;
          plugins = [
            "belak/zsh-utils path:completion"
            "romkatv/zsh-defer"
            "getantidote/use-omz"
          ];
        };
      };

      programs.lsd = {
        enable = true;
      };

      programs.dircolors = {
        enable = true;
      };

    };

}
