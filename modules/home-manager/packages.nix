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
      bat
      bluetuith
      clipse
      cmatrix
      ffmpeg
      fzf
      grimblast
      hyprpicker
      keepassxc
      loupe
      mpv
      ncpamixer
      pavucontrol
      ripgrep
      telegram-desktop
      tlrc
      tree
      xdragon
    ]
    ++ lib.optionals myopts.additionalPackages [
      # wireshark
      android-tools
      ani-cli
      cargo
      clock-rs
      cmake
      filezilla
      github-cli
      hyprland-workspaces-tui
      jetbrains-toolbox
      krita
      networkmanagerapplet
      nix-prefetch-github
      obsidian
      onlyoffice-desktopeditors
      prismlauncher
      protonup
      qbittorrent
      teams-for-linux
      thunderbird
      timg
      tray-tui
      ungoogled-chromium
      vesktop
      youtube-music
      yt-dlp
      zola
      obs-studio
    ];
}
