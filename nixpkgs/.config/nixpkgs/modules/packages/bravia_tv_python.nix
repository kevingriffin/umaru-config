{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages}:

buildPythonPackage rec {
  pname = "bravia_tv";
  version = "1.0.6";

  src = fetchPypi {
    inherit version pname;
    sha256 = "1dqj5fcq1d58c5lsm2bh7ng1fvrdwl14m12brw5g5mzh7sqpsjh4";
  };

  doCheck = false;

  propagatedBuildInputs = [
    pythonPackages.requests
  ];
}
