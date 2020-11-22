{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages, cryptography}:

buildPythonPackage rec {
  pname = "aiohomekit";
  version = "0.2.54";

  src = fetchPypi {
    inherit version pname;
    sha256 = "0canwj6j12cal8gi8wgdf5h37w0gi08ylkv6mmj259iqqkz1ajpj";
  };

  doCheck = false;

  propagatedBuildInputs = [
    cryptography zeroconf
  ];
}
