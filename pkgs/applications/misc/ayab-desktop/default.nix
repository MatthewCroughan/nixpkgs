{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "ayab-desktop";
  version = "0.95";
  format = "other";

  src = fetchFromGitHub {
    owner = "AllYarnsAreBeautiful";
    repo = "ayab-desktop";
    rev = "v${version}";
    hash = "sha256-+iMt6l5V+NmODPWMIBbEFGbYv6YGYChSRwtrW28nhmQ=";
    fetchSubmodules = true;
  };

  postInstall = ''
    mkdir -p $out/${python3.sitePackages}
    mv src/main $out/${python3.sitePackages}/fbs
  '';

  meta = with lib; {
    description = "The AYAB Software";
    homepage = "https://github.com/AllYarnsAreBeautiful/ayab-desktop";
    changelog = "https://github.com/AllYarnsAreBeautiful/ayab-desktop/blob/${src.rev}/CHANGELOG.rst";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ matthewcroughan ];
  };
}
