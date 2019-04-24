{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "kube-ps1";
  version = "0.7.0";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "jonmosco";
    repo = pname;
    rev = "v${version}";
    sha256 = "1p01cgxa787m6pqa30kh4wqflgwc7gp11sdgzvjwykl5a3jvg80n";
  };

  installPhase = ''
    mkdir -p $out/share
    cp kube-ps1.sh $out/share

    mkdir -p $out/bin
    cat <<SCRIPT > $out/bin/kube-ps1-share
    #!/bin/sh
    # Run this script to find the shared folder where kube-ps1 lives
    echo $out/share
    SCRIPT
    chmod +x $out/bin/kube-ps1-share
  '';
}

