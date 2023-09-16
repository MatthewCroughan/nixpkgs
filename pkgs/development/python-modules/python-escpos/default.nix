{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools-scm
, pyusb
, pillow
, qrcode
, pyserial
, python-barcode
, six
, importlib-resources
, pyyaml
}:

buildPythonPackage rec {
  pname = "python-escpos";
  version = "unstable-2023-09-07";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "python-escpos";
    repo = "python-escpos";
    rev = "cfa9ecf16d18b26c4614eb65f43204ff09edb4b3";
    hash = "sha256-gBMe1I+g8sPD55EFwsi8Aj4YZUaTgJPRm/8j8s4ayq0=";
    fetchSubmodules = true;
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = "1.0";

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    pyusb
    pillow
    qrcode
    pyserial
    python-barcode
    six
    importlib-resources
    pyyaml
  ];

  pythonImportsCheck = [ "escpos" ];

  meta = with lib; {
    description = "Python library to manipulate ESC/POS printers";
    homepage = "https://github.com/python-escpos/python-escpos";
    changelog = "https://github.com/python-escpos/python-escpos/blob/${src.rev}/CHANGELOG.rst";
    license = licenses.mit;
    maintainers = with maintainers; [ matthewcroughan ];
  };
}
