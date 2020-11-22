{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages}:

buildPythonPackage rec {
  pname = "fnvhash";
  version = "0.1.0";

  src = fetchPypi {
    inherit version pname;
    sha256 = "13jsr2crcxv69n71p2mgyr4q7x5nwzvlkdmmna3kk7sg0l2xb0iy";
  };

  doCheck = false;

  propagatedBuildInputs = [
    # pythonPackages.requests
  ];
}
