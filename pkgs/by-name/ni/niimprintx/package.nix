{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication (finalAttrs: {
  pname = "niim-print-x";
  version = "0.0.47";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "labbots";
    repo = "NiimPrintX";
    tag = "v${finalAttrs.version}";
    hash = "sha256-lZiF7cq5tafd9pDS31yGVZWc2wNGOCxBKKBn14DFvx8=";
  };

  build-system = [
    python3.pkgs.poetry-core
  ];

  dependencies = with python3.pkgs; [
    appdirs
    bleak
    click
    loguru
    pillow
    pycairo
    rich
    wand
  ];

  pythonRelaxDeps = [
    "bleak"
    "pillow"
    "rich"
  ];

  meta = {
    description = "NiimPrintX is a Python library designed to seamlessly interface with NiimBot label printers via Bluetooth. This library supports a range of models including D11/B21/B1, D110, and B18";
    homepage = "https://github.com/labbots/NiimPrintX";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ matthewcroughan ];
    mainProgram = "niim-print-x";
  };
})
