{
  description = "NixOS Config";

  inputs = {
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    stable.url = "github:nixos/nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix";
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
  };

  outputs =
    {
      self,
      nixpkgs,
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
