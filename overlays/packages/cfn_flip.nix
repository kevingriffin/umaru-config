{ lib, buildPythonPackage, fetchPypi
, click, pyyaml, six, tox, pytestrunner
}:

buildPythonPackage rec {
  pname = "cfn_flip";
  version = "1.1.0.post1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "16r01ijjwnq06ax5xrv6mq9l00f6sgzw776kr43zjai09xsbwwck";
  };

  doCheck = false; # TODO: why?

  buildInputs = [ pytestrunner ];
  propagatedBuildInputs = [ click pyyaml six tox ];
}
