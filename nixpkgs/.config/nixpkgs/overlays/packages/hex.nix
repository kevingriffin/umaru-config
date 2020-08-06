{ stdenv , fetchFromGitHub , rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "hex";
  version = "v0.3.0";

  src = fetchFromGitHub {
    owner = "sitkevij";
    repo = "hex";
    rev = version;
    sha256 = "123grg6na3vzbbxhyx0d127spxy7zni6q5sjpg50f3c1x84j71ih";
  };

  cargoSha256 = "15mxky97ay1jjrbjy6y2bq3kz139gjshkv7m0syv4k57m8qrxpza";

  # cargoBuildFlags = stdenv.lib.optional withPCRE2 "--features pcre2";

  # nativeBuildInputs = [ asciidoctor installShellFiles ];
  # buildInputs = (stdenv.lib.optional withPCRE2 pcre2)
  # ++ (stdenv.lib.optional stdenv.isDarwin Security);

  # preFixup = ''
  #   installManPage $releaseDir/build/ripgrep-*/out/rg.1

  #   installShellCompletion $releaseDir/build/ripgrep-*/out/rg.{bash,fish}
  #   installShellCompletion --zsh "$src/complete/_rg"
  # '';

  meta = with stdenv.lib; {
    description = " Futuristic take on hexdump.";
    homepage = "https://github.com/sitkevij/hex";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
  };
}

