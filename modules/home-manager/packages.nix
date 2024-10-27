{pkgs, ...}:
{
  home.packages = with pkgs; [
    telegram-desktop
    tree
    alacritty
    ungoogled-chromium
    brave
    clipse
    nemo
    nomacs
    mpv
    grimblast
    easyeffects
    bluetuith
    vivid
    ripgrep
    fzf
    ani-cli
    protonup
    teams-for-linux
    zoom-us
    hyprpicker
    loupe
    youtube-music
    vesktop
    jetbrains-toolbox
    # imagemagick
    networkmanagerapplet
    keepassxc
    yt-dlp
    cmatrix
    tlrc
    obsidian
    qbittorrent
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
