{
  flake.nixosModules.nh =
    { pkgs, user }:
    {
      programs.nh = {
        enable = true;
        flake = "/home/${user}/nix";
      };
    };
}
