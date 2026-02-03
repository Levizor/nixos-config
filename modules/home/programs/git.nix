{ self, ... }:
{
  flake.homeModules.git =
    {
      pkgs,
      lib,
      myopts,
      ...
    }:
    let
      toggles = self.lib.toggles pkgs;
    in
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = myopts.git.user;
            email = myopts.git.email;
          };

          push = {
            autoSetupRemote = true;
          };
          init = {
            defaultBranch = "main";
          };

        };

        hooks = {
          post-checkout = toggles.toggleableDerivation "dark-text" (
            pkgs.writeShellScriptBin "post-checkout" ''
              dark-text --new-area -t "$(git rev-parse --abbrev-ref HEAD)" >/dev/null 2>&1 &
            ''
          );
          post-commit = toggles.toggleableDerivation "dark-text" (
            pkgs.writeShellScriptBin "post-commit" ''
              dark-text -t "COMMIT SIGNED" >/dev/null 2>&1 &
            ''
          );
        };
      };
    };
}
