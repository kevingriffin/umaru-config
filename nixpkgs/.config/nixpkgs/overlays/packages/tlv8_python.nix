{ lib, buildPythonPackage, fetchPypi
}:

buildPythonPackage rec {
  pname = "tlv8";
  version = "0.9.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0nf4ckn17bxfj2wdlhxjb0abd7nk98zx9zbanv0g18kxi7fs1f55";
  };

  propagatedBuildInputs = [
  ];
}
