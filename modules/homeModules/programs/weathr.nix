{ inputs, ... }:
{
  flake.homeModules.weathr = {
    imports = [
      inputs.weathr.homeModules.weathr
    ];

    programs.weathr = {
      enable = true;
      settings = {
        hide_hud = true;
      };
    };
  };
}
