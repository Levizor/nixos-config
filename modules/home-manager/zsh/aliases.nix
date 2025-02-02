{
  programs.zsh.shellAliases = {
    c = "wl-copy";
    p = "wl-paste";

    cop = "copypath";

    cf = "copyfile";

    def = "nh os switch -H default";

    adcom = "git commit -am";

    nixconf = "nvim ~/nix/.";

    hypr = "nvim ~/nix/modules/home-manager/wm/hyprland.nix";

    aliases = "nvim ~/nix/modules/home-manager/zsh/aliases.nix";

    zrc = "nvim ~/nix/home-manager/zsh/zsh.nix";

    cp = "cp -r";

    tree = "tree --dirsfirst";

    compress = "compress()";

    pjatk = "sshfs s30243@sftp.pjwstk.edu.pl:/ ~/pja/ -o allow-other -o user";

    grub-update = "sudo grub-mkconfig -o /boot/grub/grub.cfg";

    ls = "lsd --group-directories-first";

    la = "lsd -a --group-directories-first";

    ll = "lsd -al --group-directories-first";

    cmatrix = "cmatrix -C blue";

    z = "zathura";

    s = "source ~/zsh_config/.zshrc";

    i = "loupe";

    get = "nix-shell -p";

    uisudo = "sudo -sE ";

    up = "nvim ~/nix/modules/home-manager/packages.nix";

    ns = "nh search ";
  };
}
