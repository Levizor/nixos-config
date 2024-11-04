{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    steam-tui
    steamcmd
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

    inputs.nixvim.packages."${system}".default

    pkgs.libsForQt5.qt5.qtgraphicaleffects
    # (callPackage ./sddm.nix {})
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
}
