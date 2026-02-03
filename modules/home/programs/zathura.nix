{
  flake.homeModules.zathura =
    { pkgs, ... }:
    {
      programs.zathura = {
        enable = true;
        options = {
          selection-clipboard = "clipboard";
        };
      };
      xdg.mimeApps.defaultApplications = {
        "application/pdf" = [
          "org.pwmt.zathura.desktop"
        ];
      };
    };
}
