{
  services = {
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        hide_borders = true;
      };
    };

    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
    };
  };
}
