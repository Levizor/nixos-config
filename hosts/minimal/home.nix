{
  inputs,
  outputs,
  lib,
  ...
}:
{
  imports = [
    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager
  ];
}
