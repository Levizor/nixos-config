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
      cmake
      github-cli
      zola
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
      discord-canary
      prismlauncher
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
