{

  perSystem =
    { pkgs, ... }:
    let

      megaPackage =
        {
          lib,
          stdenv,
          fetchurl,
          dpkg,
          autoPatchelfHook,
          makeWrapper,
          libredirect,
          alsa-lib,
          at-spi2-atk,
          at-spi2-core,
          atk,
          cairo,
          cups,
          dbus,
          expat,
          fontconfig,
          freetype,
          gdk-pixbuf,
          glib,
          gtk2,
          libcap,
          libdrm,
          libX11,
          libXcomposite,
          libXcursor,
          libXdamage,
          libXext,
          libXfixes,
          libXi,
          libXinerama,
          libXrandr,
          libXrender,
          libXScrnSaver,
          libXtst,
          libxcb,
          libxkbcommon,
          libxshmfence,
          mesa,
          nspr,
          nss,
          pango,
          systemd,
          libglvnd,
          libuuid,
          zstd,
          zlib,
        }:

        stdenv.mkDerivation rec {
          pname = "mega";
          version = "12.1.0-1";

          src = fetchurl {
            url = "https://www.megasoftware.net/releases/mega_${version}_amd64_beta.deb";
            sha256 = "1lnq6pc8gj5xymimpiwprdnfy5w8jmpyw3gs3ijzky1gh93ihc21";
          };

          nativeBuildInputs = [
            dpkg
            autoPatchelfHook
            makeWrapper
          ];

          buildInputs = [
            alsa-lib
            at-spi2-atk
            at-spi2-core
            atk
            cairo
            cups
            dbus
            expat
            fontconfig
            freetype
            gdk-pixbuf
            glib
            gtk2
            libcap
            libdrm
            libX11
            libXcomposite
            libXcursor
            libXdamage
            libXext
            libXfixes
            libXi
            libXinerama
            libXrandr
            libXrender
            libXScrnSaver
            libXtst
            libxcb
            libxkbcommon
            libxshmfence
            mesa
            nspr
            nss
            pango
            systemd
            libglvnd
            libuuid
            zstd
            zlib
          ];

          unpackPhase = "dpkg-deb -x $src .";

          installPhase = ''
            runHook preInstall

            mkdir -p $out/lib/mega $out/share
            cp -r usr/lib/mega/* $out/lib/mega/
            cp -r usr/share/* $out/share/
            cp -r usr/local/share/man $out/share/ || true

            mkdir -p $out/bin
            ln -s $out/lib/mega/mega $out/bin/mega
            ln -s $out/lib/mega/megacc $out/bin/megacc

            runHook postInstall
          '';

          postFixup = ''
            REDIRECTS="/usr/lib/mega/mega_web_help.zip=$out/lib/mega/mega_web_help.zip:/usr/lib/mega/mega_web_dialogs.zip=$out/usr/lib/mega/mega_web_dialogs.zip"

            wrapProgram $out/bin/mega \
              --prefix LD_LIBRARY_PATH : $out/lib/mega \
              --set NIX_REDIRECTS "$REDIRECTS" \
              --set CHROME_DEVEL_SANDBOX "$out/lib/mega/chrome-sandbox" \
              --prefix LD_PRELOAD : "${libredirect}/lib/libredirect.so"

            wrapProgram $out/bin/megacc \
              --prefix LD_LIBRARY_PATH : $out/lib/mega \
              --set NIX_REDIRECTS "$REDIRECTS" \
              --prefix LD_PRELOAD : "${libredirect}/lib/libredirect.so"
          '';

          meta = with lib; {
            description = "Molecular Evolutionary Genetics Analysis (MEGA)";
            longDescription = ''
              MEGA is an integrated suite of tools for statistics-based comparative
              analysis of molecular sequence data based on evolutionary principles.
            '';
            homepage = "https://www.megasoftware.net/";
            # license = licenses.unfree;
            maintainers = [ ];
            platforms = [ "x86_64-linux" ];
          };
        };
    in
    {
      packages.mega = pkgs.callPackage megaPackage { };
    };
}
