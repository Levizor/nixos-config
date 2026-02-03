{
  flake.nixosModules.postgres =
    { pkgs, ... }:
    {
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql;
        ensureDatabases = [ "mydb" ];
        authentication = pkgs.lib.mkOverride 10 ''
          #type database DBuser auth-method
          local all      all    trust
        '';
      };
    };
}
