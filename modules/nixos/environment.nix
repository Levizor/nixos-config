{pkgs, ...}:
{
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

     (inputs.nvix.packages.${system}.base.extend {
        config.colorschemes.tokyonight.settings.transparent = true;
     })

    pkgs.libsForQt5.qt5.qtgraphicaleffects
    (callPackage ./sddm.nix {})
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
}
