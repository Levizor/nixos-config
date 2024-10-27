{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    vim
    git
    brightnessctl
    pulseaudioFull
    pavucontrol
    clang
    clang-tools
    cmake
    wl-clipboard
    libnotify
    killall
    rustup
    openssl
    lxqt.lxqt-policykit

    inputs.nixvim.packages."${system}".default

    pkgs.libsForQt5.qt5.qtgraphicaleffects
    (callPackage ./sddm.nix {})
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
}
