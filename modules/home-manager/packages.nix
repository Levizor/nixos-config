{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    android-tools
    krita
    thunderbird
    wcalc
    prismlauncher
    cava
    hyprland-workspaces
    ffmpeg
    eog
    loupe
    pipes
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
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
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
      config = {
        theme = "Nord";
      };
    };
  };
}
