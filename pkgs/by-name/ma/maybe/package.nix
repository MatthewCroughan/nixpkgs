{
  lib,
  stdenv,
  bundlerEnv,
  buildPackages,
  fetchFromGitHub,
  makeBinaryWrapper,
  nixosTests,
  callPackage,
  vips,
}:
stdenv.mkDerivation (
  finalAttrs:
  let
    # Use bundlerEnvArgs from passthru to allow overriding bundlerEnv arguments.
    rubyEnv = bundlerEnv finalAttrs.passthru.bundlerEnvArgs;
    # We also need a separate nativeRubyEnv to precompile assets on the build
    # host. If possible, reuse existing rubyEnv derivation.
    nativeRubyEnv =
      if stdenv.buildPlatform.canExecute stdenv.hostPlatform then
        rubyEnv
      else
        buildPackages.bundlerEnv finalAttrs.passthru.bundlerEnvArgs;

    bundlerEnvArgs = {
      name = "${finalAttrs.pname}-${finalAttrs.version}-gems";
      gemdir = ./.;
      extraConfigPaths = [ "${./.}/.ruby-version" ];
    };
  in
  {
    pname = "maybe";
    version = "0.5.0";

    src = fetchFromGitHub {
      owner = "maybe-finance";
      repo = "maybe";
      rev = "v${finalAttrs.version}";
      hash = "sha256-eIIRgL30Fmbx0hOEo9LtgcsyuHFicnxOCMg9jM4/wyM=";
    };

    strictDeps = true;
    nativeBuildInputs = [
      nativeRubyEnv
      makeBinaryWrapper
    ];

    buildInputs = [ vips ];

    inherit rubyEnv;

    buildPhase = ''
      runHook preBuild
      DATABASE_URL=nulldb:/// RAILS_ENV=production rake assets:precompile
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p -- "$out"/{share,bin}
      cp -a -- . "$out"/share/maybe
      makeWrapper "$rubyEnv"/bin/puma "$out"/bin/maybe \
        --add-flags -C \
        --add-flags config/puma.rb \
        --chdir "$out"/share/maybe
      runHook postInstall
    '';

    passthru = {
      inherit bundlerEnvArgs;
      updateScript = callPackage ./update.nix { };
      tests = {
        inherit (nixosTests) maybe;
      };
    };

  meta = {
    description = "The personal finance app for everyone";
    homepage = "https://github.com/maybe-finance/maybe.git";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ matthewcroughan ];
    mainProgram = "maybe";
    platforms = lib.platforms.all;
  };
  }
)
