{ lib
, stdenv
, fetchFromGitHub
, scons
, SDL2
, libGL
, pkg-config
}:

stdenv.mkDerivation rec {
  pname = "clk";
  version = "2023-09-10";

  src = fetchFromGitHub {
    owner = "TomHarte";
    repo = "CLK";
    rev = version;
    hash = "sha256-apkMlFgJ6b0KRV2YLmRRCouHyonMmiQAp1Ba5dcRjUA=";
  };

  patchPhase = ''
    substituteInPlace OSBindings/SDL/SConstruct --replace 'sdl2-config' 'pkg-config sdl2'
    substituteInPlace OSBindings/SDL/SConstruct --replace "env.Append(CCFLAGS = ['--std=c++17', '--std=c++1z', '-Wall', '-O2', '-DNDEBUG'])" "env.Append(CCFLAGS = ['--std=c++17', '--std=c++1z', '-Wall', '-O2', '-DNDEBUG'], PKG_CONFIG_PATH = '"${SDL2}/lib/pkgconfig"')"
  '';

  preConfigure = ''
    export PKG_CONFIG_PATH=${SDL2}/lib/pkgconfig
  '';

  preBuild = ''
    cd OSBindings/SDL
  '';

  buildInputs = [
    libGL
    SDL2
  ];

  nativeBuildInputs = [
    pkg-config
    scons
  ];

  meta = with lib; {
    description = "A latency-hating emulator of 8- and 16-bit platforms: the Acorn Electron, Amstrad CPC, Apple II/II+/IIe and early Macintosh, Atari 2600 and ST, ColecoVision, Enterprise 64/128, Commodore Vic-20 and Amiga, MSX 1/2, Oric 1/Atmos, Sega Master System, Sinclair ZX80/81 and ZX Spectrum";
    homepage = "https://github.com/TomHarte/CLK";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "clk";
    platforms = platforms.all;
  };
}
