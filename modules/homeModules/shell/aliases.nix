{ self, ... }:
{
  flake.homeModules.shell-aliases =
    {
      pkgs,
      lib,
      myopts,
      system,
      ...
    }:
    let
      shellAliases = {
        c = lib.getExe self.packages.${system}.clip-copy;
        p = lib.getExe self.packages.${system}.clip-paste;

        mirror = "hyprctl keyword monitor HDMI-A-1, preferred, auto, 1, mirror, eDP-1";

        sz = "du -sh";

        tree = "lsd --tree";

        dad = "${lib.getExe pkgs.dragon-drop} -a -x";

        clock = "clock-rs";

        cop = "copypath";

        cf = "copyfile";

        nhs = "nh os switch -H ${myopts.nh.host}";

        lab = "sudo nixos-rebuild switch --flake '.#lab' --target-host=levizor@nixlab --sudo";

        adcom = "git commit -am";

        battery = "upower -i $(upower -e | grep BAT) | grep -E 'state|to full|percentage'";

        nixconf = "nvim ~/nix/.";

        hypr = "nvim ~/nix/modules/homeModules/wm/hyprland.nix";

        aliases = "nvim ~/nix/modules/homeModules/zsh/aliases.nix";

        zrc = "nvim ~/nix/home/zsh/zsh.nix";

        cp = "rsync -r --info=progress2 --human-readable";

        pjatk = "${lib.getExe pkgs.sshfs} s30243@sftp.pjwstk.edu.pl:/ ~/pja/";

        lss = "lsd --sort=time --reverse";

        z = "zathura --fork";

        i = "${lib.getExe pkgs.loupe}";

        get = "nix-shell -p";

        uisudo = "sudo -sE ";

        up = "nvim ~/nix/modules/nixosConfigurations/laptop/home.nix";

        ns = "nh search ";
      };
    in
    {
      programs.zsh.shellAliases = shellAliases;
      programs.fish.shellAbbrs = shellAliases;
      programs.bash.shellAliases = shellAliases;
    };
}
