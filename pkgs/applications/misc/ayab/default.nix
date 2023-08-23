{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "ayab-desktop";
  version = "0.95";

  src = fetchFromGitHub {
    owner = "AllYarnsAreBeautiful";
    repo = "ayab-desktop";
    rev = "v${version}";
    hash = "sha256-+iMt6l5V+NmODPWMIBbEFGbYv6YGYChSRwtrW28nhmQ=";
    fetchSubmodules = true;
  };

  meta = with lib; {
    description = "The AYAB Software";
    homepage = "https://github.com/AllYarnsAreBeautiful/ayab-desktop";
    changelog = "https://github.com/AllYarnsAreBeautiful/ayab-desktop/blob/${src.rev}/CHANGELOG.rst";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
  };
}
