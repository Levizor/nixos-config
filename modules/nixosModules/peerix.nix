{ inputs, ... }:
{
  flake.nixosModules.peerix =
    { ... }:
    {
      imports = [ inputs.peerix.nixosModules.peerix ];
      services.peerix = {
        enable = true;
        trackerUrl = "https://sophronesis.dev/peerix";
      };
    };
}
