{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    brightnessctl
    cmake
    curl
    gcc
    git
    inputs.nixvim.packages."${system}".default
    killall
    libnotify
    pavucontrol
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pulseaudioFull
    python3
    rustup
    unzip
    vim
    wl-clipboard
    zip
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
  virtualisation.waydroid.enable = true;
  virtualisation.docker = {
    enable = true;
  };
}
