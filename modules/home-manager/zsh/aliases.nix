{
  programs.zsh = {
    shellAliases = {
      c = "clear";

			def = "sudo nixos-rebuild switch --flake /home/levizor/nix/#default";

			nixconf = "nvim ~/nix/.";

      hypr="nvim ~/nix/modules/home-manager/wm/hyprland.nix";

      aliases="nvim ~/nix/modules/home-manager/zsh/aliases.nix";

      zrc="nvim ~/nix/home-manager/zsh/zsh.nix";

      cp="cp -r";

      tree="tree --dirsfirst";

      compress="compress()";

      pjatk="sshfs s30243@sftp.pjwstk.edu.pl:/ ~/pja/ -o allow-other -o user";

      grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg";

      ls="lsd --group-directories-first";

      la="lsd -a --group-directories-first";

      ll="lsd -al --group-directories-first";

      cmatrix="cmatrix -C black";

      htheme="nvim ~/.config/hypr/hyprtheme.conf";

      z="zathura";

      s="source ~/zsh_config/.zshrc";

      home="nvim ~/nix/home-manager/default.nix";

      os="nvim ~/nix/os/default.nix";

      i="loupe";

      get="nix-shell -p";

      uisudo="sudo -sE ";

      up="nvim ~/nix/modules/home-manager/packages.nix";
    };
  };
}
