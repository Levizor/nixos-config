{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager
  ];
}
