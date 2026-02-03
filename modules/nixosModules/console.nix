{
  flake.nixosModules.kmscon =
    { pkgs, ... }:
    {
      services.kmscon = {
        enable = true;
        fonts = [
          {
            name = "FiraCode Nerd Font Mono";
            package = pkgs.nerd-fonts.fira-code;
          }
        ];
      };
    };
}
