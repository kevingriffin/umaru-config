{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages}:

buildPythonPackage rec {
  pname = "braviarc-homeassistant";
  version = "0.3.7.dev0";

  src = fetchPypi {
    inherit version pname;
    sha256 = "0ylv76xc7a538m5520y32daglcysnpxxbvff2kh179jzp78k27qb";
  };

  doCheck = false;

  propagatedBuildInputs = [
    pythonPackages.requests
  ];
}
