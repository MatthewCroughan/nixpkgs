{ lib, buildPythonPackage, pythonOlder, fetchFromGitHub, pyparsing, pytest, typing-extensions }:

buildPythonPackage rec {
  version = "f9c0d10febbfb29d26a316164267d3059079f79f";
  pname = "ezdxf";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "mozman";
    repo = "ezdxf";
    rev = "${version}";
    sha256 = "sha256-oEeGIwbfWwny0d7MvP5Kd23OxI1GPrjf+6sbNyllRIw=";
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
