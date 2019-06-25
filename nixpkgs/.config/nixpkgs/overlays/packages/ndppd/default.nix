{ stdenv, fetchFromGitHub, gzip, pkg-config }:

stdenv.mkDerivation rec {
  pname = "ndppd";
  version = "20180315";
  buildDeps = [ gzip pkg-config ];

  patches = [ ./ndppd-nix.patch ];

  src = fetchFromGitHub {
    owner = "chrisandreae";
    repo = pname;
    rev = "4ee63013d47f801129f1ab89d1d104e2d40fd18e";
    sha256 = "12c1hdy75smxg3j550gl4p9lb4gdd10n3q68xi3z8n35xvk60lc9";
  };

  makeFlags = [
    "SBINDIR=${placeholder "out"}/bin" 
    "MANDIR=${placeholder "out"}/man"
  ];
}
