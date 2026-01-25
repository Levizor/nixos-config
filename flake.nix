{
  description = "Levizor NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-25.05";

    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim = {
    #   url = "github:Levizor/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixvim = {
      url = "github:Levizor/nvix";
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

    lan-mouse.url = "github:feschber/lan-mouse";

    wallpapers.url = "github:Levizor/Wallpapers";

    cachyos.url = "github:xddxdd/nix-cachyos-kernel/release";

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

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
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              allowUnsupportedSystem = true;
            };
          };

          modPath = ./modules;
        in
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit
              inputs
              user
              system
              modPath
              ;
            mylib = import ./mylib {
              inherit pkgs inputs system;
              lib = pkgs.lib;
            };
          };
          modules = [
            inputs.disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            configPath
            ./modules/nixos/common.nix
            ./modules/home/common.nix
            ./modules/options
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem linux nixpkgs ./hosts/laptop/configuration.nix;
        minimal = mkSystem linux nixpkgs ./hosts/minimal/configuration.nix;
        iso = mkSystem linux nixpkgs ./hosts/iso/configuration.nix;
        vps = mkSystem linux stable ./hosts/vps/configuration.nix;
        lab = mkSystem linux nixpkgs ./hosts/lab/configuration.nix;
      };
    };
}
