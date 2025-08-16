{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.11";

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
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      ...
    }@inputs:
    let
      mylib = import ./mylib/default.nix { inherit inputs; };
    in
    with mylib;
    {
      nixosConfigurations = {
        laptop = mkSystem ./hosts/laptop/configuration.nix;
        minimal = mkSystem ./hosts/minimal/configuration.nix;
        live-iso = mkSystem ./hosts/live-iso/configuration.nix;
        vps = mkSystem ./hosts/vps/configuration.nix;
      };

      options = ./modules/options;
    };
}
