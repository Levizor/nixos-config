{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    curl
    vim
    git
    brightnessctl
    pulseaudioFull
    pavucontrol
    cmake
    wl-clipboard
    libnotify
    killall
    rustup
    zip
    unzip
    gcc
    python3

    inputs.nixvim.packages."${system}".default

    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
  virtualisation.waydroid.enable = true;
}
