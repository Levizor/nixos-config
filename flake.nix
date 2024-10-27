{
	description = "NixOS Config";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};


	outputs = {self, nixpkgs, home-manager, ...}@inputs:

	let
		system = "x86_64-linux";
	in
  {
		nixosConfigurations= {
      default = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/default/configuration.nix
          ];
        specialArgs = {
            inherit inputs self system;
        };
      };
		};
	};





}
