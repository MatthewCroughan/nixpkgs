{ lib
, buildPythonPackage
, fetchPypi
, setuptools
, wheel
, hjson
, ninja
, numpy
, psutil
, py-cpuinfo
, pydantic
, pynvml
, torch
, tqdm
}:

buildPythonPackage rec {
  pname = "deepspeed";
  version = "0.13.1";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-vWQHHmyI/eWPzTDrdPwRoGcMXWlb6wtE5Y2hzERtZ1U=";
  };

  propagatedBuildInputs = [
    hjson
    ninja
    numpy
    psutil
    py-cpuinfo
    pydantic
    pynvml
    torch
    tqdm
  ];

  nativeBuildInputs = [
    setuptools
    wheel
  ];

  pythonImportsCheck = [ "deepspeed" ];

  meta = with lib; {
    description = "DeepSpeed library";
    homepage = "https://pypi.org/project/deepspeed/";
    license = licenses.asl20;
    maintainers = with maintainers; [ matthewcroughan ];
  };
}
