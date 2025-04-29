{
  programs.zsh.shellAliases = {
    c = "wl-copy";
    p = "wl-paste";

    dad = "xdragon -a -x";

    clock = "clock-rs";

    cop = "copypath";

    cf = "copyfile";

    lap = "nh os switch -H laptop";

    vps = "nh os switch -H vps";

    min = "nh os switch -H minimal";

    adcom = "git commit -am";

    battery = "upower -i $(upower -e | grep BAT) | grep -E 'state|to full|percentage'";

    nixconf = "nvim ~/nix/.";

    hypr = "nvim ~/nix/modules/home-manager/wm/hyprland.nix";

    aliases = "nvim ~/nix/modules/home-manager/zsh/aliases.nix";

    zrc = "nvim ~/nix/home-manager/zsh/zsh.nix";

    cp = "cp -r";

    tree = "tree --dirsfirst";

    compress = "compress()";

    pjatk = "sshfs s30243@sftp.pjwstk.edu.pl:/ ~/pja/ -o allow-other -o user";

    grub-update = "sudo grub-mkconfig -o /boot/grub/grub.cfg";

    # ls = "lsd --group-directories-first";

    # la = "lsd -a --group-directories-first";

    # ll = "lsd -al --group-directories-first";

    z = "zathura";

    s = "source ~/zsh_config/.zshrc";

    i = "loupe";

    get = "nix-shell -p";

    uisudo = "sudo -sE ";

    up = "nvim ~/nix/modules/home-manager/packages.nix";

    ns = "nh search ";
  };
}
