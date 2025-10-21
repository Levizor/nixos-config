{
  imports = [
    ./displayManager.nix
    ./wayland.nix
  ];

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

}
