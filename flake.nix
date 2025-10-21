{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.11";
    lab-flake.url = "path:./hosts/lab/";

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

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

    # nix-minecraft.url = "github:Infinidoge/nix-minecraft";
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

    vicinae.url = "github:vicinaehq/vicinae";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      stable,
      home-manager,
      ...
    }@inputs:
    let
      linux = "x86_64-linux";
      user = "levizor";
      mkSystem =

        system: nixpkgs: configPath:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs user system;
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
            (
              { ... }:
              {
                myopts.git = {
                  user = "Levizor";
                  email = "levizor@disroot.org";
                };
              }
            )
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem linux nixpkgs ./hosts/laptop/configuration.nix;
        minimal = mkSystem linux nixpkgs ./hosts/minimal/configuration.nix;
        live-iso = mkSystem linux nixpkgs ./hosts/live-iso/configuration.nix;
        vps = mkSystem linux stable ./hosts/vps/configuration.nix;
        lab = inputs.lab-flake.nixosConfigurations.lab;
      };

      options = ./modules/options;
    };
}
