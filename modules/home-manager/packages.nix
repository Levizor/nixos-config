{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    waybar
    android-tools
    ani-cli
    bluetuith
    cava
    clipse
    clock-rs
    cmatrix
    discord-canary
    distrobox
    ffmpeg
    filezilla
    fzf
    gh
    grimblast
    hyprland-workspaces
    hyprland-workspaces-tui
    hyprpicker
    jetbrains-toolbox
    keepassxc
    krita
    loupe
    mpv
    ncpamixer
    nemo
    networkmanagerapplet
    nix-prefetch-github
    obsidian
    onlyoffice-desktopeditors
    pavucontrol
    prismlauncher
    protonup
    qbittorrent
    ripgrep
    telegram-desktop
    thunderbird
    timg
    tlrc
    tree
    ungoogled-chromium
    vesktop
    vieb
    wcalc
    whatsie
    wireshark
    youtube-music
    yt-dlp
    zoom-us
  ];
  programs = {
    obs-studio = {
      enable = true;
    };
    bat = {
      enable = true;
    };
  };
}
