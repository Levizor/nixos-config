{
  inputs,
  outputs,
  config,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  myopts = {
    additionalPackages = true;
    steam = true;
  };

  imports = [
    ../../modules/nixos

    ./hardware-configuration.nix
    ./disko-config.nix
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ../../modules/stylix

    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };
}
