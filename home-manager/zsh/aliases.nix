{
  programs.zsh = {
    shellAliases = {
      c = "clear";

			rebuild = "sudo nixos-rebuild switch --flake /home/levizor/nix/ --impure";

			nixconf = "nvim ~/nix/.";

      mirrors="sudo reflector --verbose --latest 10 --country 'Poland' --age 6 --sort rate --save /etc/pacman.d/mirrorlist";

      hypr="nvim ~/.config/hypr/hyprland.conf";

      binds="nvim ~/.config/hypr/binds.conf";

      i3c="nvim ~/.config/i3/config";

      aliases="nvim ~/nix/home-manager/zsh/aliases.nix";

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

    };
  };
}
