{ stdenv , fetchFromGitHub , rustPlatform, libiconv, darwin }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
unstablePkgs.rustPlatform.buildRustPackage rec {
  name = "gitui";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "extrawurst";
    repo = name;
    rev = version;
    sha256 = "0lxpdwpxizc4bczh5cl2x2xbbdam3fakvgcbbrdh43czgjwb4ds1";
  };

  cargoSha256 = "0slvvm4ph7vh61135db6yvaqvcgmqsslvh62h6pwdrj6fqsv4l0w";

  buildInputs = [ libiconv ] ++
    (stdenv.lib.optional stdenv.isDarwin darwin.apple_sdk.frameworks.Security);

  meta = with stdenv.lib; {
    description = "Blazing fast terminal client for git written in Rust.";
    homepage = "https://github.com/extrawurst/gitui";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}
