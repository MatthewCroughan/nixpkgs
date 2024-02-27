{ ioquake3, fetchFromGitHub, pan-bindings, libsodium }:
ioquake3.overrideAttrs (old: {
  pname = "ioq3-scion";
  version = "foobar-unstable";
  buildInputs = old.buildInputs ++ [
    pan-bindings
    libsodium];
  src = fetchFromGitHub {
    owner = "lschulz";
    repo = "ioq3-scion";
    rev = "a92e7e251c8d792d43a51c45041540ebba2bee2b";
    hash = "sha256-OsC2LkTJjR/qvZYGhKwtu5is3VoMwWzsqDeglqfXxSQ=";
  };
})
