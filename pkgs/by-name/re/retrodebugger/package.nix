{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  SDL2,
  gtk3,
  alsa-lib,
}:
stdenv.mkDerivation rec {
  pname = "retro-debugger";
  version = "0.64.70";

  src = fetchFromGitHub {
    owner = "slajerek";
    repo = "RetroDebugger";
    rev = "v${version}";
    hash = "sha256-Ux7cv1UllpPQVWM9yueHz3SSgE7f7VDubU8yFTZKdq4=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    alsa-lib
  ];

  buildInputs = [
    SDL2
    gtk3
  ];

  meta = {
    description = "Retro Debugger is a multiplatform debugger APIs host for retro computers: C64 (Vice), Atari800 and NES (NestopiaUE";
    homepage = "https://github.com/slajerek/RetroDebugger";
    license = lib.licenses.unfree; # weird custom license
    maintainers = with lib.maintainers; [ matthewcroughan ];
    mainProgram = "retro-debugger";
    platforms = lib.platforms.all;
  };
}
