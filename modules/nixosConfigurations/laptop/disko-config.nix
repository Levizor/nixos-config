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
                content =
                  let
                    mountOptions = [
                      "noatime"
                      "compress=zstd:3"
                      "space_cache=v2"
                    ];
                  in
                  {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "@persist" = {
                        mountpoint = "/persist";
                        inherit mountOptions;
                      };

                      "@persist-home" = {
                        mountpoint = "/persist-home";
                        inherit mountOptions;
                      };

                      "@root" = {
                        mountpoint = "/";
                        inherit mountOptions;
                      };

                      "@nix" = {
                        mountpoint = "/nix";
                        inherit mountOptions;
                      };

                      "@home" = {
                        mountpoint = "/home";
                        inherit mountOptions;
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
