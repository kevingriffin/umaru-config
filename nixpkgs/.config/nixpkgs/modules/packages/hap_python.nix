{ lib, buildPythonPackage, fetchPypi
, curve25519-donna, ed25519, cryptography, zeroconf
, pycrypto, tlslite-ng, ecdsa
}:

buildPythonPackage rec {
  pname = "HAP-python";
  version = "3.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0a0ndqscwz340p8wjf8ijhndxgsawsgqqk5n7czwcbw7qfk2wyz1";
  };

  propagatedBuildInputs = [
    curve25519-donna ed25519 cryptography zeroconf
    pycrypto tlslite-ng ecdsa
  ];
}

