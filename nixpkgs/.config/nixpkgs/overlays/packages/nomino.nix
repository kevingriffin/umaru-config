{ stdenv , fetchFromGitHub , rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "nomino";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "yaa110";
    repo = name;
    rev = version;
    sha256 = "1qmy73gmmf0i9svzrw2jz7nlypfybyd1izwd1a13fgm9dn7amja3";
  };

  cargoSha256 = "18g4rmai80al0gj29al33lh81xam98n8g1dffld7pmak0n4jxb5w";

  meta = with stdenv.lib; {
    description = "Batch rename utility for developers.";
    homepage = "https://github.com/yaa110/nomino";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}

