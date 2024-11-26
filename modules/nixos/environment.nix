{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    kew
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
    # openssl
    # lxqt.lxqt-policykit
    zip
    unzip
    gcc


    inputs.nixvim.packages."${system}".default

    pkgs.libsForQt5.qt5.qtgraphicaleffects
    # (callPackage ./sddm.nix {})
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
  virtualisation.waydroid.enable = true;
}
