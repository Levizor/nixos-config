{ inputs, pkgs, ... }:
{
  imports = [
    ./zen.nix
    ./obs.nix
    ./distrobox.nix
    ./ssh.nix
    ./zathura.nix
    ./btop.nix
    ./fuzzel.nix
    ./firefox.nix
    ./git.nix
    ./lsd.nix
    ./mako.nix
    ./cava.nix
    ./nh.nix
    ./chromium.nix
  ];

  programs.mpv.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/gif" = [ "org.gnome.Loupe.desktop" ];
      "image/webp" = [ "org.gnome.Loupe.desktop" ];
    };
  };

}
