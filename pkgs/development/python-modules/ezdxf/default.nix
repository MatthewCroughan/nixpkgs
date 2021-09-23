{ lib, buildPythonPackage, pythonOlder, fetchFromGitHub, pyparsing, pytest, typing-extensions }:

buildPythonPackage rec {
  version = "0.16.6";
  pname = "ezdxf";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "mozman";
    repo = "ezdxf";
    rev = "v${version}";
    sha256 = "sha256-OrpAb1mYPxt0xcdzYl8eN0COjXImu8794sp92XlOtt8=";
  };

  checkInputs = [ pytest ];
  checkPhase = "pytest tests integration_tests";

  doCheck = false;

  propagatedBuildInputs = [ pyparsing typing-extensions ];

  meta = with lib; {
    description = "Python package to read and write DXF drawings (interface to the DXF file format)";
    homepage = "https://github.com/mozman/ezdxf/";
    license = licenses.mit;
    maintainers = with maintainers; [ hodapp ];
    platforms = platforms.unix;
  };
}
