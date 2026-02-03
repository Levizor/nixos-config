{ self, ... }:
{
  flake.nixosModules.environment =
    {
      pkgs,
      ...
    }:
    let
      toggles = self.lib.toggles pkgs;
    in
    {
      environment = {
        enableAllTerminfo = true;
        systemPackages = with pkgs; [
          curl
          gcc
          git
          killall
          python3
          vim
          zip
          unzip
          man-pages
          man-pages-posix
          toggles.toggle
        ];

        variables = {
          TERMINAL = "kitty -1";
          NIXPKGS_ALLOW_UNFREE = 1;
        };
      };

      documentation.dev.enable = true;
    };
}
