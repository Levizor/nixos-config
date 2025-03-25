{
  inputs,
  lib,
  pkgs,
  myopts,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  home.packages =
    with pkgs;
    [
      # gimp
      github-cli
      xdragon
      bluetuith
      cava
      clipse
      clock-rs
      cmatrix
      ffmpeg
      fzf
      grimblast
      hyprpicker
      keepassxc
      loupe
      mpv
      ncpamixer
      networkmanagerapplet
      nix-prefetch-github
      pavucontrol
      ripgrep
      telegram-desktop
      tlrc
      tree
    ]
    ++ lib.optionals myopts.additionalPackages [
      teams-for-linux
      cargo
      protonup
      yt-dlp
      youtube-music
      ungoogled-chromium
      vesktop
      thunderbird
      timg
      obsidian
      onlyoffice-desktopeditors
      filezilla
      qbittorrent
      whatsie
      wcalc
      teams-for-linux
      android-tools
      ani-cli
      distrobox
      hyprland-workspaces-tui
      tray-tui
      jetbrains-toolbox
      krita
      # prismlauncher
      # wireshark
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
