{ inputs, ... }:
{
  flake.diskoConfigurations.laptop = {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "encrypted"; # /dev/mapper/encrypted
                askPassword = true;
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "noatime"
                        "compress=zstd:3"
                        "space_cache=v2"
                      ];
                    };

                    "@root/.snapshots" = {
                      mountpoint = "/.snapshots";
                      mountOptions = [
                        "noatime"
                        "compress=zstd:3"
                        "space_cache=v2"
                      ];
                    };

                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "noatime"
                        "compress=zstd:3"
                        "space_cache=v2"
                      ];
                    };

                    "@swap" = {
                      mountpoint = "/.swapvol";
                      swap = {
                        swapfile = {
                          size = "8G";
                          path = "swapfile";
                        };
                      };
                    };

                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "noatime"
                        "compress=zstd:3"
                        "space_cache=v2"
                      ];
                    };

                    "@home/.snapshots" = {
                      mountpoint = "/home/.snapshots";
                      mountOptions = [
                        "noatime"
                        "compress=zstd:3"
                        "space_cache=v2"
                      ];
                    };

                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
