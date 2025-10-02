{
  inputs,
  pkgs,
  config,
  mylib,
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
        wl-clipboard
        mylib.toggle
      ]
      ++ lib.optionals config.myopts.sound [
        pavucontrol
        pulseaudioFull
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
