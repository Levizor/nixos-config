{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
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
    loupe
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
