{ inputs }:
let
  mylib = (import ./default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
rec {
  mkSystem =
    config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs mylib;
      };
      modules = [
        config
        outputs.nixosModules.default
      ];
    };

}
