{
  lib,
  stdenv,
  gcc13Stdenv,
  fetchFromGitHub,
  cmake,
  SDL2,
  pkg-config,
  gtk3,
}:

gcc13Stdenv.mkDerivation rec {
  pname = "mt-engine-sdl";
  version = "3.06";

  src = fetchFromGitHub {
    owner = "slajerek";
    repo = "MTEngineSDL";
    rev = "v${version}";
    hash = "sha256-iRbrFi4sOeaaEyQFnCvnS7ticdDAd8ZoJdaGqFy9Opk=";
  };

  nativeBuildInputs = [
    cmake
    SDL2
    pkg-config
    gtk3
  ];

  meta = {
    description = "MTEngineSDL is a SDL2+ImGui engine for macOS, Linux and MS Windows";
    homepage = "https://github.com/slajerek/MTEngineSDL";
    license = lib.licenses.unfree; # weird custom license
    maintainers = with lib.maintainers; [ matthewcroughan ];
    mainProgram = "mt-engine-sdl";
    platforms = lib.platforms.all;
  };
}
