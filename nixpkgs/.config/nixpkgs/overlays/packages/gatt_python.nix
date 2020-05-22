{ lib, buildPythonPackage, fetchPypi
, dbus-python, pygobject3
# , zeroconf, hkdf, dbus-python, pycairo, pygobject3, cryptography, ed25519, gatt
}:

buildPythonPackage rec {
  pname = "gatt";
  version = "0.2.7";

  src = fetchPypi {
    inherit version pname;
    sha256 = "0fjf066jixk30fr8xwfalwfnhqpr56yv0cccyypnx2qp9bi9svb2";
  };

  propagatedBuildInputs = [
    dbus-python pygobject3
    # zeroconf hkdf dbus-python pycairo pygobject3 cryptography ed25519 gatt
  ];
}
