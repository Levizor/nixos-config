{ inputs, lib, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.disko.flakeModules.default
    inputs.flake-parts.flakeModules.modules
  ];

  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "My custom library output";
  };

  config = {
    systems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

  };
}
