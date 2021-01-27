{ lib, fetchFromGitHub, buildGoPackage }:

buildGoPackage rec {
  pname = "osc52-pbcopy";
  version = "1.0.0";
  goPackagePath = "cmd/pbcopy";
  src = fetchFromGitHub {
    owner = "skaji";
    repo = "remote-pbcopy-iterm2";
    rev = "74321acbd33a563feaabc2d57287618638a6d13a";
    sha256 = "10vvz30sv7c7b35w818c2aj564l0b08nkj6r2v7jfmmbzb30xk4h";
  };
  postInstall = ''
    mv $out/bin/pbcopy $out/bin/osc52-pbcopy
  '';
}
