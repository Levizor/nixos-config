{
  description = "Levizor NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-25.11";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

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

    lan-mouse.url = "github:feschber/lan-mouse";

    wallpapers.url = "github:Levizor/Wallpapers";

    cachyos.url = "github:xddxdd/nix-cachyos-kernel/release";

    devcook = {
      url = "github:Levizor/devcook";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    weathr.url = "github:Veirt/weathr";

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
