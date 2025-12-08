{
  services = {
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        hide_borders = true;
        session_log = false;
      };
    };

    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
    };
  };
}
