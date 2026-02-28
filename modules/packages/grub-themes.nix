{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.hollow-knight-grub-theme = pkgs.stdenv.mkDerivation {
        pname = "hollow-knight-grub-theme";
        version = "unstable-2026";

        src = pkgs.fetchFromGitHub {
          owner = "sergoncano";
          repo = "hollow-knight-grub-theme";
          rev = "9515f805f72dc214e3da59967f0b678d9910adf1";
          hash = "sha256-0hn3MFC+OtfwtA//pwjnWz7Oz0Cos3YzbgUlxKszhyA=";
        };

        installPhase = ''
          runHook preInstall

          cp -r hollow-grub $out

          runHook postInstall
        '';
      };
      packages.grubsouls-grub-theme = pkgs.stdenv.mkDerivation {
        pname = "grubsouls-grub-theme";
        version = "unstable-2026";

        src = pkgs.fetchFromGitHub {
          owner = "PedroMMarinho";
          repo = "grubsouls-theme";
          rev = "114f7fe6a5b71ec9cc231b22789867f6a975aaf1";
          hash = "sha256-w3dKgu0t8RDut6MK7A8T7soqSeVckN3z0LVtZPh8BUY=";
        };

        installPhase = ''
          runHook preInstall

          cp -r grubsouls $out

          runHook postInstall
        '';
      };

      packages.minegrub-world-sel-grub-theme = pkgs.stdenv.mkDerivation {
        pname = "minegrub-world-sel-grub-theme";
        version = "unstable-2026";

        src = pkgs.fetchFromGitHub {
          owner = "Lxtharia";
          repo = "minegrub-world-sel-theme";
          rev = "0527bf0bdd0bcad46f228e35ee6cf133cb436aec";
          hash = "sha256-pNRReDfR36MZd3X/zsT+qNzGtLvmg41mgjdiM/Rxtd8=";
        };

        installPhase = ''
          runHook preInstall

          cp -r minegrub-world-selection $out

          runHook postInstall
        '';
      };

      packages.lain-grub-theme = pkgs.stdenv.mkDerivation {
        pname = "lain-grub-theme";
        version = "unstable-2026";

        src = pkgs.fetchFromGitHub {
          owner = "uiriansan";
          repo = "LainGrubTheme";
          tag = "1.0.1";
          hash = "sha256-gDwNolJ28UQUjE2G2U0bvzh29E9EEiet9SlItbY46IQ=";
        };

        installPhase = ''
          cp -r lain $out
        '';
      };

    };
}
