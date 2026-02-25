{
  lib,
  fetchFromGitHub,
  makeWrapper,
  maven,
  fluidsynth,
  jre,
  jdk25,
  fetchurl,
  tree,
}:

let
  soundfont = fetchurl {
    url = "https://archive.org/download/jjazz-lab-sound-font/JJazzLab-SoundFont.sf2";
    name = "soundfont";
    sha256 = "sha256-UKueqnEd068CVEQg91iBvoM6h2+QUcYNgMIx9jh9jYA=";
  };
in 

maven.buildMavenPackage rec {
  pname = "jjazzlab";
  version = "5.1";
  mvnJdk = jdk25;

  src = fetchFromGitHub {
    owner = "jjazzboss";
    repo = "JJazzLab";
    tag = "${version}";
    hash = "sha256-WdP/Je4ryX5WPpgBBM2gNgJEXvE4lE5aJSqOxUv1KOk=";
  };

  mvnHash = "sha256-JfhYCuMm0kTyK52P3miUB8O3mkPQIsCrPHIkD5polsI=";
  
  nativeBuildInputs = [
    makeWrapper
    fluidsynth
    tree
  ];
  prePatch = ''
    cp ${soundfont} ./plugins/FluidSynthEmbeddedSynth/src/main/soundfont/
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/etc $out/extra $out/jjazzlab $out/platform
    tree ./app/application
    install -Dm755 app/application/target/jjazzlab/bin/jjazzlab $out/bin/jjazzlab
    cp -r app/application/target/jjazzlab/etc/* $out/etc/
    cp -r app/application/target/jjazzlab/extra/* $out/extra/
    cp -r app/application/target/jjazzlab/jjazzlab/* $out/jjazzlab/
    cp -r app/application/target/jjazzlab/platform/* $out/platform/

    runHook postInstall
  '';
}
