{ lib, buildGoModule, fetchFromGitHub, fetchpatch }:

buildGoModule rec {
  pname = "hydroxide";
  version = "0.2.18-1";

  src = fetchFromGitHub {
    owner = "matthewcroughan";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-P+T8aIrDDKHbkpf7ZYEGCLxN9BCdJQCj2m/NJVdiP8c=";
  };

  vendorSha256 = "sha256-jkiTpDsJN628YKkFZcng9P05hmNUc3UeFsanLf+QtJY=";

  doCheck = false;

  subPackages = [ "cmd/hydroxide" ];

  meta = with lib; {
    description = "A third-party, open-source ProtonMail bridge";
    homepage = "https://github.com/emersion/hydroxide";
    license = licenses.mit;
    maintainers = with maintainers; [ Br1ght0ne ];
    platforms = platforms.unix;
  };
}
