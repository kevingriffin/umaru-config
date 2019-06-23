{ lib, buildPythonPackage, fetchPypi
, curve25519-donna, ed25519, pycryptodome, tlslite-ng, zeroconf
, ecdsa
}:

buildPythonPackage rec {
  pname = "HAP-python";
  version = "2.5.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0br52gv4jdcs5vk71i02f7afc8wml8561kfpgr17krcyvxjyazxw";
  };

  propagatedBuildInputs = [
    curve25519-donna ed25519 pycryptodome tlslite-ng zeroconf
    ecdsa
  ];
}
