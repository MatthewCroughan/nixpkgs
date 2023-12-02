{ lib
, stdenv
, fetchFromGitHub
, SDL2
, cudaPackages
, which
, makeWrapper
, wget
, Accelerate
, CoreGraphics
, CoreML
, CoreVideo
}:

stdenv.mkDerivation rec {
  pname = "whisper-cpp";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "ggerganov";
    repo = "whisper.cpp";
    rev = "refs/tags/v${version}" ;
    hash = "sha256-TXB5cQ32HA96i7ciJheuGrr5yxj/tBB8/KcaOTGO/HQ=";
  };

  # The upstream download script tries to download the models to the
  # directory of the script, which is not writable due to being
  # inside the nix store. This patch changes the script to download
  # the models to the current directory of where it is being run from.
#  patches = [ ./download-models.patch ];

  nativeBuildInputs = [
    makeWrapper
    which
    cudaPackages.cudatoolkit
  ];

  buildInputs = [
    SDL2
    cudaPackages.libcublas
    cudaPackages.cudatoolkit.lib
  ] ++ lib.optionals stdenv.isDarwin [ Accelerate CoreGraphics CoreML CoreVideo ];

  env = { WHISPER_CUBLAS = "1"; } // (lib.optionalAttrs stdenv.isDarwin {
    WHISPER_COREML = "1";
    WHISPER_COREML_ALLOW_FALLBACK = "1";
  });

  makeFlags = [ "main" "stream" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ./main $out/bin/whisper-cpp
    cp ./stream $out/bin/whisper-cpp-stream

    cp models/download-ggml-model.sh $out/bin/whisper-cpp-download-ggml-model

    wrapProgram $out/bin/whisper-cpp-download-ggml-model \
      --prefix PATH : ${lib.makeBinPath [wget]}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Port of OpenAI's Whisper model in C/C++";
    longDescription = ''
      To download the models as described in the project's readme, you may
      use the `whisper-cpp-download-ggml-model` binary from this package.
    '';
    homepage = "https://github.com/ggerganov/whisper.cpp";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ dit7ya hughobrien ];
  };
}
