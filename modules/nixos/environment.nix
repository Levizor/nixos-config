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
      TERMINAL = "kitty -1";
      NIXPKGS_ALLOW_UNFREE = 1;
    };
  };

  programs.nano.enable = false;
  documentation.dev.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [
        "gtk"
      ];
      hyprland = {
        default = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
}
