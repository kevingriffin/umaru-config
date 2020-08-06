{ stdenv , fetchFromGitHub , rustPlatform, libiconv, darwin }:

rustPlatform.buildRustPackage rec {
  name = "delta";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "dandavison";
    repo = name;
    rev = version;
    sha256 = "1i4ddz2fivn5h35059b68z3lfw48psak79aab6pk7d8iamz4njb9";
  };

  cargoSha256 = "1k050015fmkzkrw24xkxw8zghda3kcfq85w6van662iy6yp258fl";

  buildInputs = [ libiconv ] ++
    (stdenv.lib.optional stdenv.isDarwin darwin.apple_sdk.frameworks.Security);

  meta = with stdenv.lib; {
    description = "A viewer for git and diff output";
    homepage = "https://github.com/dandavison/delta";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}

