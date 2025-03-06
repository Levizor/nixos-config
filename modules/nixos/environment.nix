{
  inputs,
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      brightnessctl
      cmake
      curl
      gcc
      git
      inputs.nixvim.packages."${system}".default
      killall
      libnotify
      pavucontrol
      # pkgs.libsForQt5.qt5.qtgraphicaleffects
      pulseaudioFull
      python3
      unzip
      vim
      wl-clipboard
      zip
    ];
    variables = {
      EDITOR = "nvim";
    };
  };

  programs.nano.enable = false;
  virtualisation = {
    waydroid.enable = true;
    docker = {
      enable = true;
    };
  };
}
