{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "Levizor";
    userEmail = "levizorri@gmail.com";

    hooks = {
      post-checkout = lib.getExe (
        pkgs.writeShellApplication {
          name = "post-checkout";
          text = ''
            dark-text --new-area -t "$(git rev-parse --abbrev-ref HEAD)" >/dev/null 2>&1 &
          '';
        }
      );
      post-commit = lib.getExe (
        pkgs.writeShellApplication {
          name = "post-commit";
          text = ''
            dark-text -t "CODE BLESSED" >/dev/null 2>&1 &
          '';
        }
      );
    };

    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
