{ lib
, stdenv
, fetchFromGitHub
, wrapQtAppsHook
, pkg-config
, qmake
, qtwayland
, qtsvg
, postgresql
, copyDesktopItems
, makeDesktopItem
}:

stdenv.mkDerivation rec {
  pname = "pgmodeler";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "pgmodeler";
    repo = "pgmodeler";
    rev = "v${version}";
    sha256 = "sha256-yvVgBfJLjEynsqxQisDfOM99C8/QM0F44RIHAmxh4uU=";
  };

  nativeBuildInputs = [ pkg-config qmake wrapQtAppsHook copyDesktopItems ];
  qmakeFlags = [ "pgmodeler.pro" "CONFIG+=release" ];

  # todo: libpq would suffice here. Unfortunately this won't work, if one uses only postgresql.lib here.
  buildInputs = [ postgresql qtsvg qtwayland ];

  desktopItems = [(makeDesktopItem {
    desktopName = "pgModeler";
    name = "pgModeler";
    exec = pname;
    icon = "pgmodeler";
    comment = meta.description;
    type = "Application";
    categories = [ "Misc" ];
  })];

  fixupPhase = ''
    runHook preFixup

    ln -s $out/share/pgmodeler/conf/pgmodeler_logo.png $out/share/icons/pgmodeler.png

    runHook postFixup
  '';

  meta = with lib; {
    description = "A database modeling tool for PostgreSQL";
    homepage = "https://pgmodeler.io/";
    license = licenses.gpl3;
    maintainers = [ maintainers.esclear ];
    platforms = platforms.linux;
  };
}
