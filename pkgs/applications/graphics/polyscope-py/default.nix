{ lib
, stdenv
, cmake
, fetchgit
, libX11
, libXrandr
, libXinerama
, libXcursor
, libxcb
, libXi
, libGL
, python3
}:

stdenv.mkDerivation rec {
  pname = "polyscope-py";
  version = "1.3.0";

  src = fetchgit {
    url = "https://github.com/nmwsharp/polyscope-py.git";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-bAs9+EK/ive35dsvcHGGmbHnXIDvQh+eTD0xfjmGVTw=";
  };

  nativeBuildInputs = [
    python3
    cmake
  ];

  buildInputs = [
    libX11
    libXrandr
    libXinerama
    libXcursor
    libxcb
    libXi
    libGL
  ];

#  meta = with lib; {
#    description = "Free Software/Open Source software package for mapping caves";
#    longDescription = ''
#      Survex is a Free Software/Open Source software package for mapping caves,
#      licensed under the GPL. It is designed to be portable and can be run on a
#      variety of platforms, including Linux/Unix, macOS, and Microsoft Windows.
#    '';
#    homepage = "https://survex.com/";
#    changelog = "https://github.com/ojwb/survex/raw/v${version}/NEWS";
#    license = licenses.gpl2Plus;
#    maintainers = [ maintainers.matthewcroughan ];
#    platforms = platforms.all;
#  };
}
