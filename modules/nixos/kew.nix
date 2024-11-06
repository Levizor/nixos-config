{ lib
, stdenv
, fetchFromGitHub
, fftwFloat
, chafa
, freeimage
, glib
, pkg-config
, libogg
, libopus
, opusfile
, taglib
, faad2
, libnotify
, libvorbis
}:

stdenv.mkDerivation rec {
  pname = "kew";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "ravachol";
    repo = "kew";
    rev = "v${version}";
    hash = "sha256-w0EenAgAw/7tSmMuAFSaPOdboHj4ox6lqFnAuuprYxE=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ freeimage fftwFloat chafa glib libogg libopus opusfile taglib faad2 libnotify libvorbis];

  installFlags = [
    "MAN_DIR=${placeholder "out"}/share/man"
    "PREFIX=${placeholder "out"}"
  ];

  meta = with lib; {
    description = "Command-line music player for Linux";
    homepage = "https://github.com/ravachol/kew";
    platforms = platforms.linux;
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ demine ];
    mainProgram = "kew";
  };
}


