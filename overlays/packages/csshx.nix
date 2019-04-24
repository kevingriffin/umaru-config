{ stdenv, fetchurl, perl }:

stdenv.mkDerivation rec {
  pname = "csshX";
  version = "0.74";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://distfiles.macports.org/csshX/csshX-0.74.tgz";
    sha256 = "1j79l2vmqwcwfihx5a9y1xnhsd52zwryv63kr3nqvcn84wkybaga";
  };

  dontPatchShebangs = true;

  installPhase = ''
    mkdir -p $out/bin
    cp --target-directory=$out/bin csshX
  '';
}
