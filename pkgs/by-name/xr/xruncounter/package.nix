{
  lib,
  stdenv,
  fetchFromGitHub,
  jack2,
  pkg-config,
}:

stdenv.mkDerivation {
  pname = "xruncounter";
  version = "unstable-2021-01-08";

  src = fetchFromGitHub {
    owner = "Gimmeapill";
    repo = "xruncounter";
    rev = "4c234ddf154b5ea656a90ad77a440d4e2893d7a7";
    hash = "sha256-ShhkJ0GzXsJ8ZfhvVkASHeFZ5V2a/0KPj0zXpE9D/JU=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  preConfigure = ''
    mkdir -p $out/bin
  '';

  buildPhase = ''
    gcc -Wall xruncounter.c -lm `pkg-config --cflags --libs jack` -o $out/bin/xruncounter
  '';

  buildInputs = [
    jack2
  ];

  meta = {
    description = "Small linux tool written in C by Hermann Meyer (aka https://github.com/brummer10) to measure jack xruns and evaluate the overall performance of a system for realtime audio";
    homepage = "https://github.com/Gimmeapill/xruncounter";
    license = lib.licenses.lgpl3;
    maintainers = with lib.maintainers; [ matthewcroughan ];
    mainProgram = "xruncounter";
    platforms = lib.platforms.all;
  };
}
