{
	description = "Config";
	
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
    stylix.url = "github:danth/stylix";
	};


	outputs = {nixpkgs, home-manager, ...}@inputs: 

	let 
		system = "x86_64-linux";
	in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [ 
          ./nixos/configuration.nix 
          inputs.stylix.nixosModules.stylix
        ];
		};

		homeConfigurations.levizor = home-manager.lib.homeManagerConfiguration {
			pkgs = nixpkgs.legacyPackages."${system}";
			modules = [ 
            ./home-manager/home.nix 
        ];
		};

	};





}
