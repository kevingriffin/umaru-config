{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages}:

buildPythonPackage rec {
  pname = "getmac";
  version = "0.8.2";

  src = fetchPypi {
    inherit version pname;
    sha256 = "0s6ka96nr549k9jqpyqaj5vi18465qcmi1vsl37lhql5f45x40fm";
  };

  doCheck = false;

  propagatedBuildInputs = [
  ];
}
