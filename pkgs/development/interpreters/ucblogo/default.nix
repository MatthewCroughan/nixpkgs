{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation {
  pname = "ucb-logo";
  version = "unstable-2019-09-05";

  src = fetchFromGitHub {
    owner = "brianharvey";
    repo = "UCBLogo";
    rev = "f7b8a77e145fa0965cf45714fb4ad1f09f22b0a7";
    hash = "sha256-ecYXDdsovd4iahNd8Xt5sPOCTZTlvkSoO43efR7NF3o=";
  };

  postUnpack = "sourceRoot=\${sourceRoot}/source";

  meta = with lib; {
    description = "Berkeley Logo interpreter";
    homepage = "https://github.com/brianharvey/UCBLogo/tree/master";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ matthewcroughan ];
  };
}
