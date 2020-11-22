{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages}:

buildPythonPackage rec {
  pname = "base36";
  version = "0.1.1";

  src = fetchPypi {
    inherit version pname;
    sha256 = "15hs1h3ybvyi3z151a2wzwr653b3z56ha0hi9byxb6s9qn1if8kg";
  };

  doCheck = false;

  propagatedBuildInputs = [
    # pythonPackages.requests
  ];
}
