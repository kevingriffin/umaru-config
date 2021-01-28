{ lib, buildPythonPackage, fetchPypi
, curve25519-donna, ed25519, cryptography, zeroconf
, pycrypto, tlslite-ng, ecdsa
}:

buildPythonPackage rec {
  pname = "HAP-python";
  version = "3.1.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0iqj3xajs5g89jnngsbydmik9583ly10yysl90j416ckzck50pi2";
  };

  propagatedBuildInputs = [
    curve25519-donna ed25519 cryptography zeroconf
    pycrypto tlslite-ng ecdsa
  ];
}

