{
  lib,
  rustPlatform,
  fetchFromGitHub,
  rocksdb_8_11,
}:

rustPlatform.buildRustPackage rec {
  pname = "walrus";
  version = "1.31.1";

  src = fetchFromGitHub {
    owner = "MystenLabs";
    repo = "walrus";
    rev = "mainnet-v1.31.1";
    hash = "sha256-H/kKy2HYd6FeJZlAYIRvLu0v/P+C7BQOKOk+XAZmunE=";
  };

  doCheck = false;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-lwyeV+pYRA8QeriLS4K2ZAtEaxVZAKghxjnC4L3gNYA=";
  };

  nativeBuildInputs = [
    # Needed for librocksdb_8_11-sys
    rustPlatform.bindgenHook
  ];

  env = {
    GIT_REVISION = "fuckyou";
    # Dynamically link rocksdb_8_11
    ROCKSDB_INCLUDE_DIR = "${rocksdb_8_11}/include";
    ROCKSDB_LIB_DIR = "${rocksdb_8_11}/lib";
  };



  meta = {
    description = "A decentralized blob store using Sui for coordination and governance";
    homepage = "https://github.com/MystenLabs/walrus";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ matthewcroughan ];
    mainProgram = "walrus";
  };
}
