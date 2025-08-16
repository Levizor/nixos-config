{
  inputs,
  pkgs,
  config,
  ...
}:
{
  environment = {
    systemPackages =
      with pkgs;
      [
        # libsForQt5.qt5.qtgraphicaleffects
        curl
        gcc
        git
        inputs.nixvim.packages."${system}".default
        killall
        python3
        vim
        zip
        unzip
        man-pages
        man-pages-posix
      ]
      ++ lib.optionals config.myopts.sound [
        # I now some things aren't about sound, I am too lazy to make more options
        pavucontrol
        pulseaudioFull
        brightnessctl
        wl-clipboard
      ];

    variables = {
      EDITOR = "nvim";
      NIXPKGS_ALLOW_UNFREE = 1;
    };
  };

  programs.nano.enable = false;
  documentation.dev.enable = true;
}
