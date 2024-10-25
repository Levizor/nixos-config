{inputs, outputs, ...}:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./disko-config.nix
    inputs.disko.nixosModules.disko
    ./home.nix
  ];
}
