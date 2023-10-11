{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, protobuf
, bzip2
, sqlite
, zstd
, stdenv
, darwin
, rocksdb
}:

rustPlatform.buildRustPackage {
  pname = "moksha";
  version = "unstable-2023-10-04";

  src = fetchFromGitHub {
    owner = "ngutech21";
    repo = "moksha";
    rev = "6612e491019535c6c46d099042560fbb4c7165e1";
    hash = "sha256-AMbDZ8zRJcI0gXqcEZahogqa+QaIXBZe2UFV1EkNi5s=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "fedimint-aead-0.1.0" = "sha256-twHTap4+CnQ/MG1rdTRLK33Yq/nePWSSvBHe94Q58ME=";
      "ring-0.16.20" = "sha256-05WGAkONNa2f/5mH/es7lzX/nXXr47ovQYvHsP+DZJY=";
      "secp256k1-zkp-0.7.0" = "sha256-fpCnbKbJvOy9DLvx5YjNI9qdMNjbUWq3RevQS38uWn4=";
      "threshold_crypto-0.4.0" = "sha256-EXjXT6NlRovOJINYM5QO8em+QJrtyPW5R78kAEx/Wvo=";
    };
  };

  FEDIMINT_BUILD_FORCE_GIT_HASH = "";
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
    protobuf
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    bzip2
    sqlite
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  env = {
    ROCKSDB_INCLUDE_DIR = "${rocksdb}/include";
    ROCKSDB_LIB_DIR = "${rocksdb}/lib";
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = with lib; {
    description = "A Cashu wallet and mint written in Rust";
    homepage = "https://github.com/ngutech21/moksha";
    license = licenses.mit;
    maintainers = with maintainers; [ matthewcroughan ];
    mainProgram = "moksha";
  };
}
