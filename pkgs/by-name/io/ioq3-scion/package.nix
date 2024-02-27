{ ioquake3, fetchFromGitHub }:
ioquake3.overrideAttrs {
  pname = "ioq3-scion";
  version = "foobar-unstable";
  src = fetchFromGitHub {
    owner = "lschulz";
    repo = "ioq3-scion";
    rev = "a92e7e251c8d792d43a51c45041540ebba2bee2b";
    hash = "sha256-OsC2LkTJjR/qvZYGhKwtu5is3VoMwWzsqDeglqfXxSQ=";
  };
}
