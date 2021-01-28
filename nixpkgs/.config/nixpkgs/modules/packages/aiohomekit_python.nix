{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages, cryptography}:

buildPythonPackage rec {
  pname = "aiohomekit";
  version = "0.2.60";

  src = fetchPypi {
    inherit version pname;
    sha256 = "02sqzp0z04sdyj467y4xv3iv6qk26gz7f77rrlpgvz0m5g96vnkh";
  };

  doCheck = false;

  propagatedBuildInputs = [
    cryptography zeroconf
  ];
}
