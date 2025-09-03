{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "sui";
  version = "1.54.2";

  src = fetchFromGitHub {
    owner = "MystenLabs";
    repo = "sui";
    rev = "mainnet-v${version}";
    hash = "sha256-8kn037e64e9bZ6+x7RTfIc2q1XmFIDdA3/3mJh4CsuQ=";
  };

  env = {
    GIT_REVISION = "fuckyou";
  };

  doCheck = false;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-Uimw27cFigKsmRHinEO5sTeuKoiyuSryGg1Lt7A40/o=";
  };

  nativeBuildInputs = [
    # Needed for librocksdb_8_11-sys
    rustPlatform.bindgenHook
  ];

  meta = {
    description = "Sui, a next-generation smart contract platform with high throughput, low latency, and an asset-oriented programming model powered by the Move programming language";
    homepage = "https://github.com/MystenLabs/sui/tree/mainnet-v1.54.2";
    changelog = "https://github.com/MystenLabs/sui/blob/${src.rev}/RELEASES.md";
    license = with lib.licenses; [ cc-by-40 asl20 ];
    maintainers = with lib.maintainers; [ ];
    mainProgram = "sui";
  };
}
