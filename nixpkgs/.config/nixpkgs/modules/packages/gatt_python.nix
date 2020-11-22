{ lib, buildPythonPackage, fetchPypi
, dbus-python, pygobject3, pythonPackages
# , zeroconf, hkdf, dbus-python, pycairo, pygobject3, cryptography, ed25519, gatt
}:

buildPythonPackage rec {
  pname = "pygatt";
  version = "4.0.5";

  src = fetchPypi {
    inherit version pname;
    sha256 = "0z8srfghwn7ns0qyb59l454p3arhipq35mgxylz3llq35z3hwkkz";
  };

  propagatedBuildInputs = [
    dbus-python pygobject3 pythonPackages.nose pythonPackages.pyserial pythonPackages.enum-compat
    # zeroconf hkdf dbus-python pycairo pygobject3 cryptography ed25519 gatt
  ];
}
