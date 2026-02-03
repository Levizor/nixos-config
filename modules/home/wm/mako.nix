{
  flake.homeModules.mako =
    { pkgs, ... }:
    {
      services.mako = {
        enable = true;
        settings = {
          default-timeout = 3000;
          border-radius = 5;
        };
      };
    };
}
