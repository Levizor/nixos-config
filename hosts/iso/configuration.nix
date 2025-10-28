{
  inputs,
  modulesPath,
  mylib,
  lib,
  user,
  modPath,
  ...
}:
{

  networking = {
    hostName = "nixiso";
    firewall.enable = lib.mkForce false;
  };

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ]
  ++ mylib.useModules (modPath + "/nixos") [
    "stylix"
    "hardware"
    "battery"
    "graphical"
    "networking"
    "printing"
    "sound"
    "nvim"
    "filesystems"
    "environment"
  ];

  home-manager = {
    users."${user}" = {
      imports = mylib.useModules (modPath + "/home") (
        lib.flatten [
          (mylib.prefixList "programs/" [
            "btop"
            "git"
            "vicinae"
            "zathura"
            "zen"
          ])
          (mylib.prefixList "terminals/" [
            "kitty"
            "tmux"
          ])
          "wm/hyprland"
          "zsh"
        ]
      );

      home.packages = [
        # laptop specific packages
      ];
    };
  };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
