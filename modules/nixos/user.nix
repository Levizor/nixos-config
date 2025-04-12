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
    ];
    initialHashedPassword = "$y$j9T$Y4cdALSpdofTRmGbYlgDj0$JRiBJEs4RduXZcjkZTzVOCJtVsbtRDp7O7x5rdUwXSB";
  };
}
