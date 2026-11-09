{inputs, ...}:
{
  flake.nixosModules.iets = {
    imports = [
      inputs.iets.nixosModules.default
    ];

    iets.classic.enable = true;
    
  };
}
