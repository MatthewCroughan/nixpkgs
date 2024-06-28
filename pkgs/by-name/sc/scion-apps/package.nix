{ lib
, buildGoModule
, fetchFromGitHub
, openpam
}:

buildGoModule {
  pname = "scion-apps";
  version = "unstable-2024-04-05";

  src = builtins.fetchGit { url = "https://github.com/MatthewCroughan/scion-apps.git"; rev = "15441d616ed88761b85d3c05191e815f589a0a7d"; };

  vendorHash = "sha256-UqX3jwsQt8QDlz2j1w+GIMTeVDoC2+LACHFqTbJ1+Xk=";

  postPatch = ''
    substituteInPlace webapp/web/tests/health/scmpcheck.sh \
      --replace-fail "hostname -I" "hostname -i"
  '';

  postInstall = ''
    # Add `scion-` prefix to all binaries
    for f in $out/bin/*; do
      filename="$(basename "$f")"
      mv -v $f $out/bin/scion-$filename
    done

    # Fix nested subpackage names
    mv -v $out/bin/scion-server $out/bin/scion-ssh-server
    mv -v $out/bin/scion-client $out/bin/scion-ssh-client

    # Include static website for webapp
    mkdir -p $out/share
    cp -r webapp/web $out/share/scion-webapp
  '';

  buildInputs = [
    openpam
  ];

  ldflags = [ "-s" "-w" ];

  meta = with lib; {
    description = "Public repository for SCION applications";
    homepage = "https://github.com/netsec-ethz/scion-apps";
    license = licenses.asl20;
    maintainers = with maintainers; [ matthewcroughan sarcasticadmin ];
  };
}
