{
  pkgs,
  ...
}:
{
  users = {
    defaultUserShell = pkgs.zsh;
    users.levizor = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
        "audio"
        "wireshark"
        "minecraft"
        "libvirtd"
        "docker"
      ];
      initialHashedPassword = "";
    };

  };
}
