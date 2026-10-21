{ self, inputs, ... }:
{
  flake.nixosModules.sops =
    { config, lib, pkgs, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops = {
        defaultSopsFile = "${self}/secrets.yaml";
        defaultSopsFormat = "yaml";

        age = {
          sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
          generateKey = false;
        };
      };

      environment.systemPackages = with pkgs; [
        sops
        age
        ssh-to-age
      ];
    };
}
