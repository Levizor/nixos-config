{ pkgs, lib, ... }:
{
  services = {
    minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;

      servers.smp = {
        enable = true;
        jvmOpts = "-Xmx3G -Xms2G";
        package = pkgs.fabricServers.fabric-1_21_5;

        serverProperties = {
          online-mode = false;
          server-port = 25565;
          difficulty = "hard";
          gamemode = "survival";
          max-players = 10;
          white-list = true;
          motd = "NixOS Minecraft Server!";

          allow-nether = false;

          max-world-size = 5000;
        };
        symlinks = with pkgs; {
          plugins = linkFarmFromDrvs "plugins" (
            builtins.attrValues {
              AuthMeReReloaded = fetchurl {
                url = "https://cdn.modrinth.com/data/3IEZ9vol/versions/oezVemzR/AuthMe-5.7.0-FORK-Universal.jar";
                sha256 = "sha256-C/uW2T8LZZeR303yuYuV3C1twashF4fw8byXpgTWEi4=";
              };
            }
          );
          mods = linkFarmFromDrvs "mods" (
            builtins.attrValues {
              Fabric-API = fetchurl {
                url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/FZ4q3wQK/fabric-api-0.119.9%2B1.21.5.jar";
                sha256 = "sha256-Bo9zMisO6IKtyXsgzse4sqIvfA595bnxEyLRKJBhIqo=";
              };
              Lithium = fetchurl {
                url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/VWYoZjBF/lithium-fabric-0.16.2%2Bmc1.21.5.jar";
                sha256 = "sha256-XqvnQxASa4M0l3JJxi5Ej6TMHUWgodOmMhwbzWuMYGg=";
              };
              MemoryLeakFix = fetchurl {
                url = "https://cdn.modrinth.com/data/NRjRiSSD/versions/5xvCCRjJ/memoryleakfix-fabric-1.17%2B-1.1.5.jar";
                sha256 = "sha256-uKwz1yYuAZcQ3SXkVBFmFrye0fcU7ZEFlLKKTB2lrd4=";
              };
              Krypton = fetchurl {
                url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/neW85eWt/krypton-0.2.9.jar";
                sha256 = "sha256-uGYia+H2DPawZQxBuxk77PMKfsN8GEUZo3F1zZ3MY6o=";
              };
              FerriteCore = fetchurl {
                url = "https://cdn.modrinth.com/data/uXXizFIs/versions/CtMpt7Jr/ferritecore-8.0.0-fabric.jar";
                sha256 = "sha256-K5C/AMKlgIw8U5cSpVaRGR+HFtW/pu76ujXpxMWijuo=";
              };
              Chunky = fetchurl {
                url = "https://cdn.modrinth.com/data/fALzjamp/versions/mhLtMoLk/Chunky-Fabric-1.4.36.jar";
                sha256 = "sha256-vLttrvBeviawvhMk2ZcjN5KecT4Qy+os4FEqMPYB77U=";
              };

              PlasmoVoice = fetchurl {
                url = "https://cdn.modrinth.com/data/1bZhdhsH/versions/pf1ZGzbI/plasmovoice-fabric-1.21.5-2.1.4%2Bcb9658f-SNAPSHOT.jar";
                sha256 = "sha256-oRe2t4GnqZtaRqrYpaRLUU/5GuuTJ6SUN32jVjqhFY4=";
              };

              CardBoard = fetchurl {
                url = "https://cdn.modrinth.com/data/MLYQ9VGP/versions/9N4AXvHR/Cardboard-1.21.4.jar";
                sha256 = "sha256-zUsYto6yu6996RnysxYQuuAB6CHxEr+v0QXLBfzN2KQ=";
              };

              Icommon = fetchurl {
                url = "https://cdn.modrinth.com/data/SVKv1SZo/versions/caR6lov0/iCommon-Fabric-bundle.jar";
                sha256 = "sha256-EgtUJR74tVDBC+CBL/Ye99njKAUrDxIte148acRKzwg=";
              };
            }
          );
        };

      };

    };

  };
}
