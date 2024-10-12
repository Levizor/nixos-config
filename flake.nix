{
	description = "Config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

                stylix.url = "github:danth/stylix";
		nvix.url = "github:niksingh710/nvix";
		nixvim.url = "github:mikaelfangel/nixvim-config";

	};


	outputs = {self, nixpkgs, home-manager, ...}@inputs : 

	let 
		system = "x86_64-linux";
	in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ 
			  ./nixos/configuration.nix
			  inputs.stylix.nixosModules.stylix
        		];
			specialArgs = {
			    inherit inputs self system;
			};
		};
	};





}
