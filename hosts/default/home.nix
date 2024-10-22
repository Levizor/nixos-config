{inputs, outputs, ...}:
{
  imports = [
    outputs.modules/home-manager
    inputs.home-manager.nixosModules.home-manager
    outputs.modules/stylix/nord.nix
    inputs.stylix.nixosModules.stylix
  ];
}
