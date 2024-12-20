{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
  wayland,
  libGL,
}:
rustPlatform.buildRustPackage rec {
  pname = "wpaperd";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "danyspin97";
    repo = "wpaperd";
    rev = "585f691145664317ee02c631287b85cdb7b3a76e";
    hash = "sha256-F+mBCFz8vhTzOT2GvP8R7CmFCyTAQjC0jvB61A895gU=";
  };

  cargoHash = "sha256-RTTd7Z+omDS4rL5GWtwrfq2u2HxfPFPeIJ+W79Vtl9M=";

  nativeBuildInputs = [
    pkg-config
  ];
  buildInputs = [
    wayland
    libGL
    libxkbcommon
  ];

  meta = with lib; {
    description = "Minimal wallpaper daemon for Wayland";
    longDescription = ''
      It allows the user to choose a different image for each output (aka for each monitor)
      just as swaybg. Moreover, a directory can be chosen and wpaperd will randomly choose
      an image from it. Optionally, the user can set a duration, after which the image
      displayed will be changed with another random one.
    '';
    homepage = "https://github.com/danyspin97/wpaperd";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [DPDmancul fsnkty];
    mainProgram = "wpaperd";
  };
}
