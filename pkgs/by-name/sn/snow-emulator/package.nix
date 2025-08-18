{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  bzip2,
  libgit2,
  libxkbcommon,
  vulkan-loader,
  zlib,
  zstd,
  stdenv,
  darwin,
  wayland,
  SDL2,
}:

rustPlatform.buildRustPackage rec {
  pname = "snow";
  version = "unstable-2025-08-18";

  src = fetchFromGitHub {
    owner = "twvd";
    repo = "snow";
    rev = "e87e90efcffd30859e7226218fea409aca9b49e8";
    hash = "sha256-w1+JhVGffRb55ehW46NkRdb3FmqqPF3dygYF8+nY4Zg=";
    fetchSubmodules = true;
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "ecolor-0.30.0" = "sha256-zGbwk98WS5YrwOTDS/X6EEQa0k3CdihVDCB+X7FmhJA=";
      "egui-file-dialog-0.9.0" = "sha256-/RQHEyNHNKYlO03ozxZSRSUuRjyz9SCCU0+q2sYPeC0=";
      "fluxfox-0.2.0" = "sha256-CqcGrialkkQpmPvjpTvZEM9RqRdMzQDQ4JM4sNVAHXA=";
    };
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    bzip2
    libgit2
    libxkbcommon
    vulkan-loader
    SDL2
    zlib
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.CoreGraphics
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.IOKit
    darwin.apple_sdk.frameworks.Metal
    darwin.apple_sdk.frameworks.QuartzCore
  ] ++ lib.optionals stdenv.isLinux [
    wayland
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "Classic Macintosh emulator";
    homepage = "https://github.com/twvd/snow";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "snow";
  };
}
