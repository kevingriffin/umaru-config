{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages}:

buildPythonPackage rec {
  pname = "pysesame2";
  version = "1.0.2";

  src = fetchPypi {
    inherit version pname;
    sha256 = "0rdx7kv9211dq34w6p31k17q1hia6922lnyz69fdlg8ycsdayckn";
  };

  propagatedBuildInputs = [
    pythonPackages.requests
  ];
}
