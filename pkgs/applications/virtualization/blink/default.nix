{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "blink";
  version = "0.9.2";

  src = fetchFromGitHub {
    owner = "jart";
    repo = "blink";
    rev = version;
    hash = "sha256-GQ1uOZr75CXLQ6aUX4oohJhwsYy41StaZiQRNrD/FXQ=";
  };

  meta = with lib; {
    description = "Tiniest x86-64-linux emulator";
    homepage = "https://github.com/jart/blink";
    license = licenses.isc;
    maintainers = with maintainers; [ matthewcroughan ];
  };
}
