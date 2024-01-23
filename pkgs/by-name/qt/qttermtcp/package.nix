{ lib
, stdenv
, fetchFromGitHub
, libsForQt5
}:

stdenv.mkDerivation rec {
  pname = "qttermtcp";
  version = "0.73";

  env.NIX_CFLAGS_COMPILE = "-Wno-error=format-security";

  src = fetchFromGitHub {
    owner = "g8bpq";
    repo = "QtTermTCP";
    rev = version;
    hash = "sha256-omvJ4jOQnEDc2aPqT8LkJDpo8iWsLoREyqEmq959TA8=";
  };

  installPhase = ''
    ls -lah
    ls -lah
    ls -lah
    ls -lah
    ls -lah
    ls -lah
    ls -lah
    ls -lah
    exit 1
  '';

  nativeBuildInputs = [
    libsForQt5.qmake
    libsForQt5.wrapQtAppsHook
  ];

  buildInputs = [
    libsForQt5.qtserialport
    libsForQt5.qtmultimedia
  ];

  meta = with lib; {
    description = "";
    homepage = "https://github.com/g8bpq/QtTermTCP";
#    license = licenses.unfree; # FIXME: nix-init did not found a license
    maintainers = with maintainers; [ ];
    mainProgram = "qt-term-tcp";
    platforms = platforms.all;
  };
}
