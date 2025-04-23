{ stdenv, autoPatchelfHook, curl }:
let
  djjr = builtins.fetchTarball {
    url = "https://diskjockey.onegeekarmy.eu/files/djjr/djjr-linux-x86_64.tar.gz";
    sha256 = "0lvqr0fb79j6rlwa3jz005wnqqbm2nkyai7gvdk1khwlw1lvvynv";
  };
in
stdenv.mkDerivation {
  name = "djjr";
  nativeBuildInputs = [
    autoPatchelfHook
    stdenv.cc.cc.lib
  ];
  buildInputs = [ curl ];
  installPhase = "ls -lah";
  src = null;
  dontUnpack = true;
  buildPhase = ''
    mkdir -p $out/bin
    cp ${djjr}/djjr $out/bin/djjr
  '';
}

