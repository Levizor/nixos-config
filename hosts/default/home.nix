{inputs, outputs, ...}:
{
  imports = [
    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager
    ../../modules/stylix/nord.nix
  ];
}
