{ pkgs,  stdenv, fetchFromGitHub} :

  stdenv.mkDerivation rec {
    pname = "sddm-slice";
    version = "1.5.1";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sddm-slice
    '';

    src = fetchFromGitHub {
      owner = "EricKotato";
      repo = "sddm-slice";
      rev = "d412b338bcf08e48a3bb20d4c8a93f5b441c9587";
      hash = "sha256-ybvSEH8H8EezcaGIQ5/AakaSDjMD1TWUUaZx0tw6upU=";
    };  
    # buildInputs = [
    #   pkgs.libsForQt5.qt5.qtgraphicaleffects 
    # ];
  }

