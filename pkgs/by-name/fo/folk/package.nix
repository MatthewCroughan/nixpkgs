{
  lib,
  stdenv,
  fetchFromGitHub,
  nix-update-script,
  openssl,
  libz,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "folk";
  version = "0-unstable-2026-05-30";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "FolkComputer";
    repo = "folk";
    rev = "2130200be6ac623ba42d366443e25fe1cee884ef";
    hash = "sha256-gX8+WR/SCAPUIaWHg7DlvinZaDPopgJn7fbQP+dHhP8=";
    fetchSubmodules = true;
  };

  buildInputs = [
    libz
    openssl
  ];

  preBuild = ''
    make deps
  '';

  prePatch = ''
    substituteInPlace ./Makefile --replace-fail '/bin/echo' 'echo'
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv ./folk $out/bin
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Physical computing system";
    homepage = "https://github.com/FolkComputer/folk";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "folk";
    platforms = lib.platforms.all;
  };
})
