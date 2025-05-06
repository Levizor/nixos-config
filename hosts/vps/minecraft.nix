{ pkgs, lib, ... }:
{
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      25565
      #bedrock with geyser
      19132
    ];
    allowedTCPPorts = [
      25565
      19132
    ];
  };

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
          view-distance = 16;
          spawn-protection = 0;
          online-mode = false;
          level-seed = "-2032795982907864146";
          server-port = 25565;
          difficulty = "hard";
          gamemode = "survival";
          max-players = 10;
          white-list = true;
          motd = "NixOS Minecraft Server!";

          # max-world-size = 3000;
        };
        symlinks = with pkgs; {
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

              EasyAuth = fetchurl {
                url = "https://cdn.modrinth.com/data/aZj58GfX/versions/MdRRckj6/easyauth-mc1.21.5-3.1.11.jar";
                sha256 = "sha256-7Yb8JQ5er/gsaM5xg6W+8M9nTaYcXcWZKG+lg2AohMQ=";
              };

              GeyserMC = fetchurl {
                url = "https://cdn.modrinth.com/data/wKkoqHrH/versions/qzYhEQza/geyser-fabric-Geyser-Fabric-2.7.0-b808.jar";
                sha256 = "sha256-jM77YMbsxN6bgpgDEfVhT0NYJ/ZO0KjvTcbkUzbo9uc=";
              };

              FloodGate = fetchurl {
                url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/nyg969vQ/Floodgate-Fabric-2.2.4-b43.jar";
                sha256 = "sha256-UbF/VyMY4Eo0SbtZqsCr0739kYbYK2ku0URZNjUPrSU=";
              };

              SkinRestorer = fetchurl {
                url = "https://cdn.modrinth.com/data/ghrZDhGW/versions/KXaMmwFV/skinrestorer-2.3.0%2B1.21.5-fabric.jar";
                sha256 = "sha256-JIWcOf1P9W0lfHWemFb/k4uiL7cILFpsMMO+noNeRGg=";
              };

              EasyWhitelist = fetchurl {
                url = "https://cdn.modrinth.com/data/LODybUe5/versions/4ndHE533/easywhitelist-mc1.20-rc1-1.0.1.jar";
                sha256 = "sha256-frtzUbOO50Askwjyz+kGqZeBWB0K/xbu2Y/XTHU+7c0=";
              };

              Sleep = fetchurl {
                url = "https://cdn.modrinth.com/data/WTzuSu8P/versions/qlOH7jKR/sleep-v.4.0.2.jar";
                sha256 = "sha256-BytI7H8+b7lvN0+CghvrvdZZfGwoL6OEDbTI4lW9S8Y=";
              };

              #Allows different versions
              ViaFabric = fetchurl {
                url = "https://cdn.modrinth.com/data/YlKdE5VK/versions/n9T0mzox/ViaFabric-0.4.18%2B104-main.jar";
                sha256 = "sha256-jN0jvX0/AmSDMl98whKbojFQmlV/tqpJk0RuKePg55M=";
              };

              VanilaDisablePortals = fetchurl {
                url = "https://cdn.modrinth.com/data/nNk5jjlY/versions/fufCCAwc/vanilla-disable-portals-1.2.7.jar";
                sha256 = "sha256-zPpMl4aW37JtATVKM4CpU+Vw/n4iS16ut4mD8PVOudI=";
              };

              CraterLib = fetchurl {
                url = "https://cdn.modrinth.com/data/Nn8Wasaq/versions/iT7V02Tu/CraterLib-Fabric-1.21.5-2.1.4.jar";
                sha256 = "sha256-qhgJa5/Y8WQmBPerFlEORFO0cnnmwnUwx595+aqPa7A=";
              };

              #depends on CraterLib
              MaintainanceMode = fetchurl {
                url = "https://cdn.modrinth.com/data/QOkEkSap/versions/D2XXq4an/MaintenanceMode-Universal-1.3.1.jar";
                sha256 = "sha256-D4USREyl/vrxHt+bhe9KN+1ZZZrE4yE8xD9Z7t7/KEE=";
              };

              PlayersLadder = fetchurl {
                url = "https://cdn.modrinth.com/data/YCcTxyDM/versions/5q9dW9LT/playerladder-fabric-1.21.4-0.7.2-beta.jar";
                sha256 = "sha256-42/a724WFyovPpIODeKdfonm+EYgODltznIF1a9CUEo=";
              };

              Sit = fetchurl {
                url = "https://cdn.modrinth.com/data/EsYqsGV4/versions/LQzcYAOs/sit%21-1.2.3.2%2B1.21.5.jar";
                sha256 = "sha256-h8PXI8wc8tix8LswP106RKfT1bTg1D5kyy7fkBGGuLE=";
              };

              FconfigLib = fetchurl {
                url = "https://cdn.modrinth.com/data/8cuS4dwo/versions/VEwOoOSv/fconfiglib-1.1.1.jar";
                sha256 = "sha256-h7x1zaSawLCmRk1OwXqI3crXtSEkdNLu2sQ0F3e2Dms=";
              };

              ClothConfig = fetchurl {
                url = "https://cdn.modrinth.com/data/9s6osm5g/versions/qA00xo1O/cloth-config-18.0.145-fabric.jar";
                sha256 = "sha256-7GcBJ2Gu6GwUCpEDWMSd28JLhS6YBweUBwVyHhv/Xn8=";
              };
            }
          );
        };
      };
    };
  };
}
