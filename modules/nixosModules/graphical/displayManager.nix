{

  flake.nixosModules.ly = {
    services = {
      displayManager.ly = {
        enable = true;
        settings = {
          animation = "matrix";
          hide_borders = true;
          session_log = false;
        };
      };
    };
  };
}
