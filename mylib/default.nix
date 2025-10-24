{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  importModule = file: import file { inherit pkgs lib inputs; };
in
rec {
  toggles = importModule ./toggles.nix;
  helpers = importModule ./helpers.nix;
  inherit (toggles)
    toggle
    toggleable
    toggleableDerivation
    ;
  inherit (helpers) useModules;
  inherit (helpers) prefixList;
}
