{ lib, buildPythonPackage, fetchPypi
, zeroconf, hkdf, dbus-python, pycairo, pygobject3, cryptography, ed25519, gatt
}:

buildPythonPackage rec {
  pname = "homekit";
  version = "0.15.0";

  src = fetchPypi {
    inherit version pname;
    sha256 = "0ngkix5z4xrd3ml24zv84in1ybffwcjlnxk7v22s4b0m9x83g5zs";
  };

  propagatedBuildInputs = [
    zeroconf hkdf dbus-python pycairo pygobject3 cryptography ed25519 gatt
  ];
}
