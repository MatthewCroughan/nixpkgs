{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  cups,
  libusb1,
  popt,
}:

stdenv.mkDerivation {
  pname = "cnijfilter-ip8700";
  version = "4.10-1";

  src = fetchurl {
    url = "https://gdlp01.c-wss.com/gds/1/0100005861/01/cnijfilter-ip8700series-4.10-1-deb.tar.gz";
    hash = "sha256-4Y/jh/40U+udTaYi6Vxsorfi9ThfLK4HVZ3EPba098c=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ cups libusb1 popt ];

  unpackPhase = ''
    tar xzf $src
    cd cnijfilter-ip8700series-4.10-1-deb
    ar x packages/cnijfilter-common_4.10-1_amd64.deb
    tar xzf data.tar.gz
    ar x packages/cnijfilter-ip8700series_4.10-1_amd64.deb
    tar xzf data.tar.gz
  '';

  installPhase = ''
    mkdir -p $out/lib/cups/filter
    mkdir -p $out/lib/cups/backend
    mkdir -p $out/share/cups/model

    cp usr/lib/cups/filter/* $out/lib/cups/filter/
    cp usr/lib/cups/backend/* $out/lib/cups/backend/
    cp usr/share/ppd/canonip8700.ppd $out/share/cups/model/
  '';

  meta = {
    description = "Canon InkJet printer drivers for PIXMA iP8700 series";
    homepage = "https://www.canon-europe.com/support/";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
    supportedPlatforms = [ "x86_64-linux" ];
  };
}

