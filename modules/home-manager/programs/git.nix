{
  pkgs,
  lib,
  mylib,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "Levizor";
    userEmail = "levizorri@gmail.com";

    hooks = {
      post-checkout = mylib.toggleableDerivation "dark-text" (
        pkgs.writeShellScriptBin "post-checkout" ''
          dark-text --new-area -t "$(git rev-parse --abbrev-ref HEAD)" >/dev/null 2>&1 &
        ''
      );
      post-commit = mylib.toggleableDerivation "dark-text" (
        pkgs.writeShellScriptBin "post-commit" ''
          dark-text -t "COMMIT SIGNED" >/dev/null 2>&1 &
        ''
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
