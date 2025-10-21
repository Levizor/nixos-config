{
  imports = [
    ./displayManager.nix
    ./xdg.nix
    ./wayland.nix
  ];

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

}
