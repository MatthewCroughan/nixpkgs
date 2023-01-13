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
}:

stdenv.mkDerivation rec {
  pname = "polyscope";
  version = "1.3.0";

  src = fetchgit {
    url = "https://github.com/nmwsharp/polyscope.git";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-IHoIe7AZlyE7SFUoT4veWquwfFQm+OWo9FQFgpef1S4=";
  };

  nativeBuildInputs = [
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

  preBuild = ''
    cd examples/demo-app
  '';

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
