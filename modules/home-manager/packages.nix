{
  inputs,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    webcord
    discord-canary
    hyprland-workspaces-tui
    timg
    clock-rs
    nix-prefetch-github
    android-tools
    krita
    thunderbird
    wcalc
    prismlauncher
    cava
    ffmpeg
    eog
    loupe
    fzf
    pavucontrol
    ncpamixer
    telegram-desktop
    tree
    ungoogled-chromium
    clipse
    nemo
    mpv
    grimblast
    bluetuith
    ripgrep
    ani-cli
    protonup
    zoom-us
    hyprpicker
    superfile
    youtube-music
    vesktop
    jetbrains-toolbox
    networkmanagerapplet
    keepassxc
    yt-dlp
    cmatrix
    tlrc
    obsidian
    qbittorrent
    # libsForQt5.qt5ct
    # libsForQt5.qtstyleplugin-kvantum
    whatsie
    filezilla
    onlyoffice-desktopeditors
    wireshark
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
