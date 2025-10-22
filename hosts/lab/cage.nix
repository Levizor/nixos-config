{
  pkgs,
  lib,
  user,
  ...
}:
{
  services.cage = {
    enable = true;
    user = user;
    program = lib.getExe (
      pkgs.writeShellScriptBin "kittyLab" ''
        ${lib.getExe pkgs.kitty} zsh -lic 'tmuxp load lab; exec zsh'
      ''
    );
    extraArguments = [
      "-s"
    ];
  };
}
