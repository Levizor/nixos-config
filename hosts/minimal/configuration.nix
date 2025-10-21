{
  inputs,
  outputs,
  config,
  mylib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ../../modules/stylix

    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager
  ]
  + mylib.useModules ./../../modules/nixos [
    "common"
    "hardware"
    "battery"
    "graphical"
    "networking"
    "printing"
    "sound"
    "nvim"
    "filesystems"
    "environment"
  ];

  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };
}
