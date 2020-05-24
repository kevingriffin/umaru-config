{ lib, pkgs, buildPythonPackage, fetchPypi
, zeroconf, hkdf, dbus-python, pycairo, pygobject3, cryptography, ed25519, gatt
}:

let
tlv8 = pkgs.callPackage ./tlv8_python.nix { inherit lib buildPythonPackage fetchPypi; };
fnvhash = pkgs.callPackage ./fnvhash_python.nix { inherit lib buildPythonPackage fetchPypi; };
in
buildPythonPackage rec {
  pname = "homekit";
  version = "0.17.0";

  src = fetchPypi {
    inherit version pname;
    sha256 = "1l8w49vihhjwdx92v9h6qyy676z4y5pn269rzhdks5h5xvp3193k";
  };

  propagatedBuildInputs = [
    zeroconf hkdf dbus-python pycairo pygobject3 cryptography ed25519 gatt tlv8 fnvhash
  ];
}
