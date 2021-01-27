{ stdenv, lib, fetchsvn }:

stdenv.mkDerivation {
  pname = "iterm2-integration";
  version = "2020-06-12";

  # Fetch a subdirectory
  src = fetchsvn {
    url = "https://github.com/gnachman/iterm2-website/trunk/source";
    rev = 2380;
    sha256 = "0y6bg1v8pbz9a5722blzh4cr5xhw2h9l2gc35i3c8iz6mk7imzfk";
  };

  installPhase = ''
    mkdir -p $out/{bin,share/iterm2}
    rm -v shell_integration/*.sh
    cp -r utilities/* $out/bin
    cp -r shell_integration $out/share/iterm2/
  '';
}
