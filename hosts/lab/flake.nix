{
  description = "Home lab system flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:Levizor/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      options = ./../../modules/options;
    in
    {
      nixosConfigurations = {
        lab = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            options
            home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko
            ./configuration.nix
            (
              { pkgs, lib, ... }:
              {
                _module.args.mylib = import ./../../mylib { inherit pkgs lib inputs; };
              }
            )
          ];
          specialArgs = { inherit inputs system; };
        };
      };
    };

}
