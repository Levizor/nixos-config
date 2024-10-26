{inputs, outputs, ...}:
{
  imports = [
    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    ../../modules/stylix/nord.nix
  ];
}
