{ ... }:
{
  useModules =
    path: names:
    map (
      name:
      let
        modulePath = path + "/${name}";
      in
      if builtins.pathExists (modulePath + ".nix") then modulePath + ".nix" else modulePath
    ) names;

  prefixList = prefix: list: map (string: prefix + string) list;

} # helper function for loading modules with list of filenames
