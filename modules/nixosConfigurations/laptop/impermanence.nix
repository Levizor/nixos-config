{inputs, ...}:
{
  flake.nixosModules.laptop = { lib, user, ... }: {
    fileSystems."/persist".neededForBoot = true;
    fileSystems."/persist-home".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;

    boot.initrd.systemd.services.wipe-root = {
      description = "Wipe BTRFS root subvolume";
      wantedBy = [ "initrd.target" ];
      requires = [ "dev-mapper-encrypted.device" ];
      after = [ "dev-mapper-encrypted.device" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
        }

        mkdir -p /btrfs_tmp
        mount /dev/mapper/encrypted /btrfs_tmp || exit 1

        # Wipe and backup @root
        if [[ -e /btrfs_tmp/@root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@root)" "+%Y-%m-%d_%H:%M:%S")
            mv /btrfs_tmp/@root "/btrfs_tmp/old_roots/$timestamp"
        fi
        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +7); do
            delete_subvolume_recursively "$i"
        done
        btrfs subvolume create /btrfs_tmp/@root

        # Wipe and backup @home
        if [[ -e /btrfs_tmp/@home ]]; then
            mkdir -p /btrfs_tmp/old_homes
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@home)" "+%Y-%m-%d_%H:%M:%S")
            mv /btrfs_tmp/@home "/btrfs_tmp/old_homes/$timestamp"
        fi
        for i in $(find /btrfs_tmp/old_homes/ -maxdepth 1 -mtime +7); do
            delete_subvolume_recursively "$i"
        done
        btrfs subvolume create /btrfs_tmp/@home

        umount /btrfs_tmp
      '';
    };

    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/var/lib/bluetooth"
        "/var/lib/tailscale"
      ];

      files = [
        "/etc/ly/save.txt"
        "/etc/machine-id"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
      ];
    };

    environment.persistence."/persist-home" = {
      hideMounts = true;
      users.${user} = {
        directories = [
          ".ssh"
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
          "Projects"
          "nix"
          ".thunderbird"
          ".cargo"
          ".gemini"
          ".steam"
          ".tmux"

          ".config/chromium"
          ".config/vivaldi"
          ".config/zen"
          ".config/vesktop"
          ".config/gcloud"
          ".config/gh"
          ".config/inkscape"
          ".config/JetBrains"
          ".config/kdeconnect"
          ".config/keepassxc"
          ".config/lan-mouse"
          ".config/nix"
          ".config/nvim"
          ".config/onlyoffice"
          ".config/qBittorrent"
          ".config/vicinae"
          ".config/wl-kbptr"
          ".config/Youtube Music"

        ] ++ map(x: ".local/share/" + x) [
          "applications"
          "keyrings"
          "pki"
          "Steam"
          "PrismLauncher"
          "TelegramDesktop"
          "qBittorrent"
          "nvim"
          "nvim-dev"
          "onlyoffice"
          "zoxide"
          "direnv"
          "fish"
          "iwctl"
          "zathura"
          "containers"
          "flatpak"
          "virtualenv"
          "virtualenvs"
          "pipenv"
          "pipx"
          "devenv"
        ] ++ map(x: ".local/state/" + x) [
          "wireplumber"
          "nvim"
          "nvim-dev"
          "lazygit"
          "ani-cli"
          "home-manager"
          "toggles"
          "vicinae"
          "wpaperd"
        ];

        files = [
          ".zsh/history"
          ".zsh/impure.zsh"
          ".config/hypr/impure.conf"
          ".config/pavucontrol.ini"
          ".viminfo"
          ".config/fish/impure.fish"
        ];
      };
    };

      users.users.${user}.hashedPasswordFile = "/persist/passwords/user-pass";
      users.users.root.hashedPasswordFile = "/persist/passwords/root-pass";
  };
}
