{inputs, outputs, ...}:
{
  imports = [
    outputs.modules/nixos
    ./hardware-configuration.nix
    ./disko-configuration.nix
    ./home.nix
  ];
}
