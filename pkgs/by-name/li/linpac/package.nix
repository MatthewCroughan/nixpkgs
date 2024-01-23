{ lib
, stdenv
, fetchurl
, autoreconfHook
, perl
, ax25-apps
, ncurses
}:

stdenv.mkDerivation rec {
  pname = "linpac";
  version = "0.28";

  src = fetchurl {
    url = "https://altushost-swe.dl.sourceforge.net/project/linpac/LinPac/0.28/linpac-0.28.tar.gz";
    sha256 = "sha256-JBRI2GGgYKG0mgSSwZvrg3EsUXaipzJxshOZDR/ir9g=";
  };

  buildInputs = [
    ax25-apps
    ncurses
  ];

  nativeBuildInputs = [
    autoreconfHook
    perl
  ];

  meta = with lib; {
    description = "Mirror of my http://sf.net/projects/linpac";
    homepage = "https://github.com/srl295/linpac";
    changelog = "https://github.com/srl295/linpac/blob/${src.rev}/NEWS";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ matthewcroughan ];
    mainProgram = "linpac";
    platforms = platforms.all;
  };
}
