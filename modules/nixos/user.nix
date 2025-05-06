{
  pkgs,
  ...
}:
{
  users.defaultUserShell = pkgs.zsh;
  users.users.levizor = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "input"
      "audio"
      "wireshark"
      "minecraft"
    ];
    initialHashedPassword = "";
  };
}
