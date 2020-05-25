{ lib, buildPythonPackage, fetchPypi
, curve25519-donna, ed25519, cryptography, zeroconf
, pycrypto, tlslite-ng, ecdsa
}:

buildPythonPackage rec {
  pname = "HAP-python";
  version = "2.8.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0h8bjp2vf4ckh9gvd4v821gmh2jiba3z0i8h77qy0yd4qzhv1wgs";
  };

  propagatedBuildInputs = [
    curve25519-donna ed25519 cryptography zeroconf
    pycrypto tlslite-ng ecdsa
  ];
}

