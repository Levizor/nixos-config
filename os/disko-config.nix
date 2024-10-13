{
#sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko /tmp/disk-config.nix
  disko.devices = {
    disk = {
      main = {
        type = "disk";
	device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02"; # for grub MBR
            };
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
	    swap = {
	      size = "8G";
	      content = {
		type = "swap";
		discardPolicy = "both";
		resumeDevice = true;
	      };
	    };
            root = {
              size = "50G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
	    home = {
	      size = "100%";
	      content = {
		type = "filesystem";
		format = "ext4";
		mountpoint = "/home";
	      };
	    };
          };
        };
      };
    };
  };
}