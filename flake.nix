{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.11";

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tray-tui = {
      url = "github:Levizor/tray-tui";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dark-text = {
      url = "github:Levizor/dark-text";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
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
      linux = "x86_64-linux";
      mkSystem =

        system: configPath:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = rec {
            inherit inputs;
          };
          modules = [
            self.outputs.options
            home-manager.nixosModules.home-manager
            configPath
            (
              { pkgs, lib, ... }:
              {
                _module.args.mylib = import ./mylib { inherit pkgs lib inputs; };
              }
            )
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem linux ./hosts/laptop/configuration.nix;
        minimal = mkSystem linux ./hosts/minimal/configuration.nix;
        live-iso = mkSystem linux ./hosts/live-iso/configuration.nix;
        vps = mkSystem linux ./hosts/vps/configuration.nix;
      };

      options = ./modules/options;
    };
}
