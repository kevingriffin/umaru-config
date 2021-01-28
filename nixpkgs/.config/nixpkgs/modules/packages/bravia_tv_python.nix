{ lib, buildPythonPackage, fetchPypi, zeroconf, pythonPackages}:

buildPythonPackage rec {
  pname = "bravia_tv";
  version = "1.0.8";

  src = fetchPypi {
    inherit version pname;
    sha256 = "1yrm2fd0y62d74ysvklrb6xa2cqfbcp0l5wkijmajgwlbdccagkm";
  };

  doCheck = false;

  propagatedBuildInputs = [
    pythonPackages.requests
  ];
}
