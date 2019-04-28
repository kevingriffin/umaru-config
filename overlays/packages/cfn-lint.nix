{ lib, buildPythonPackage, fetchPypi
, pyyaml, six, requests, aws-sam-translator, jsonpatch, jsonschema, pathlib2
}:

buildPythonPackage rec {
  pname = "cfn-lint";
  version = "0.12.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1qlsmq2q9xl246q838knaqbpmikgzd6zzffxzwhcsswgl0kppafn";
  };

  doCheck = false; # TODO: why?

  propagatedBuildInputs = [ pyyaml six requests aws-sam-translator jsonpatch jsonschema pathlib2 ];
}
