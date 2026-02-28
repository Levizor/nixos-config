{ inputs, ... }:
{
  flake.nixosModules.limine =
    { ... }:
    {
      loader.limine = {
        enable = false;
        efiSupport = true;
        biosDevice = "nodev";
        style = {
          wallpapers =
            let
              pack = inputs.wallpapers.outputs.wallpapers.alena-aenami;
              files = builtins.attrNames (builtins.readDir pack);
            in
            map (name: pack + "/${name}") files;
          interface = {
            resolution = "1920x1080x32";
          };
        };
      };

    };
}
