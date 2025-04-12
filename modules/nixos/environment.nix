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
      ]
      ++ lib.optionals config.myopts.sound [
        # I now some things aren't about sound, I am too lazy to make more options
        pavucontrol
        pulseaudioFull
        brightnessctl
        libnotify
        wl-clipboard
      ];

    variables = {
      EDITOR = "nvim";
    };
  };

  programs.nano.enable = false;
  virtualisation = {
    # waydroid.enable = true;
    # docker = {
    #   enable = true;
    # };
  };
}
