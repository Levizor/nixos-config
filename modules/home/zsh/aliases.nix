{
  pkgs,
  lib,
  myopts,
  ...
}:
{
  programs.zsh.shellAliases = {
    c = "wl-copy";
    p = "wl-paste";

    mirror = "hyprctl keyword monitor HDMI-A-1, preferred, auto, 1, mirror, eDP-1";

    sz = "du -sh";

    tree = "lsd --tree";

    cal = "cal -m3";

    dad = "xdragon -a -x";

    clock = "clock-rs";

    cop = "copypath";

    cf = "copyfile";

    nhs = "nh os switch -H ${myopts.nh.host}";

    vps = "nh os switch -H vps";

    min = "nh os switch -H minimal";

    adcom = "git commit -am";

    battery = "upower -i $(upower -e | grep BAT) | grep -E 'state|to full|percentage'";

    nixconf = "nvim ~/nix/.";

    hypr = "nvim ~/nix/modules/home/wm/hyprland.nix";

    aliases = "nvim ~/nix/modules/home/zsh/aliases.nix";

    zrc = "nvim ~/nix/home/zsh/zsh.nix";

    cp = "rsync -r --info=progress2 --human-readable";

    compress = "compress()";

    pjatk = "sshfs s30243@sftp.pjwstk.edu.pl:/ ~/pja/ -o allow-other -o user";

    grub-update = "sudo grub-mkconfig -o /boot/grub/grub.cfg";

    # ls = "lsd --group-directories-first";

    # la = "lsd -a --group-directories-first";

    # ll = "lsd -al --group-directories-first";

    z = "zathura";

    s = "source ~/zsh_config/.zshrc";

    i = "${lib.getExe pkgs.loupe}";

    get = "nix-shell -p";

    uisudo = "sudo -sE ";

    up = "nvim ~/nix/modules/home/packages.nix";

    ns = "nh search ";
  };
}
