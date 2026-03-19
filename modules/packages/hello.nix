{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        hello = pkgs.stdenv.mkDerivation rec {
          pname = "hello";
          version = "2.12.2";

          src = pkgs.fetchurl {
            url = "mirror://gnu/hello/hello-${version}.tar.gz";
            hash = "sha256-WpqZbcKSzCTc9BHO6H6S9qrluNE72caBm0x6nc4IGKs=";
          };

          buildPhase = ''
            make
          '';

          installPhase = ''
            make install
          '';
        };
      };
    };
}
