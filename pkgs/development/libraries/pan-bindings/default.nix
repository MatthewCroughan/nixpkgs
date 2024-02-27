{ lib
, stdenv
, fetchFromGitHub
, buildGo119Module
, cmake
, ncurses
, go
}:

let
  version = "unstable-2024-01-30";
  src = fetchFromGitHub {
    owner = "lschulz";
    repo = "pan-bindings";
    rev = "d0ac4724b0840028f8917bcb9eae8a344dfdab17";
    hash = "sha256-RRyivNxFy/jFsx0PiBkBgZqk9XWjQku4QNfQiqvcYKs=";
  };
  goDeps = (buildGo119Module {
    name = "fuck";
    inherit src version;
    modRoot = "go";
    vendorHash = "";
  }).goModules;
in

stdenv.mkDerivation {
  name = "pan-bindings";

  preBuild = "ls -lah ${goDeps}";
  inherit src;

  postPatch = ''
    export HOME=$TMP
    cp -r --reflink=auto ${goDeps} go/vendor
  '';

  buildInputs = [
    ncurses
    goDeps
  ];

  nativeBuildInputs = [
    cmake
    go
  ];

  meta = with lib; {
    description = "SCION PAN Bindings for C, C++, and Python";
    homepage = "https://github.com/lschulz/pan-bindings";
    license = licenses.asl20;
    maintainers = with maintainers; [ matthewcroughan ];
    mainProgram = "pan-bindings";
    platforms = platforms.all;
  };
}
