{
  pkgs,
  lib,
  mylib,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Levizor";
        email = "levizor@disroot.org";
      };

      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };

    };

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

  };

}
