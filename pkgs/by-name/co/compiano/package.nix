{
  lib,
  stdenv,
  fetchFromGitLab,
  cargo,
  meson,
  ninja,
  pkg-config,
  rustPlatform,
  rustc,
  wrapGAppsHook4,
  bzip2,
  cairo,
  dbus,
  gdk-pixbuf,
  glib,
  gtk4,
  libadwaita,
  libgit2,
  libpanel,
  openssl,
  pango,
  pipewire,
  zlib,
  zstd,
  darwin,
  alsa-lib,
  python3
}:

stdenv.mkDerivation rec {
  pname = "compiano";
  version = "unstable-2025-02-09";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "hub";
    repo = "compiano";
    rev = "87e3667e5f0523faec73b1e418ea1070b8c726d4";
    hash = "sha256-RWo8v/qyt4soD0lXJTtlFV6XH22Ksv/2ZMF2c+L7LqU=";
  };

  cargoDeps = rustPlatform.importCargoLock {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    mkdir -p $out
    DESTDIR="$out"
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    python3
    cargo
    meson
    ninja
    pkg-config
    rustPlatform.bindgenHook
    rustPlatform.cargoSetupHook
    rustc
    wrapGAppsHook4
  ];



  buildInputs = [
    bzip2
    cairo
    dbus
    gdk-pixbuf
    glib
    gtk4
    libadwaita
    libgit2
    libpanel
    openssl
    pango
    pipewire
    zlib
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ] ++ lib.optionals stdenv.isLinux [
    alsa-lib
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "Compiano is a MIDI controllable software music instrument, a Computer Piano";
    homepage = "https://gitlab.gnome.org/hub/compiano.git";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "compiano";
    platforms = lib.platforms.all;
  };
}
