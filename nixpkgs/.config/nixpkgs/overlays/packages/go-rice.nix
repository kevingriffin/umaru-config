{ lib, stdenv, buildGoModule, fetchFromGitHub }:
buildGoModule rec {
  pname = "go-rice";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "GeertJohan";
    repo = "go.rice";
    rev = "d954009f7238df62c766980934c8ea7f161d0e59";
    sha256 = "19lca5hcw9milgmjv6vlcg8vq4mz9a9sp5bpihxvyza0da6pklmf";
  };

  modSha256 = "0m9qs81dx5p6kc192a114gnkzlpdwgcr1a1r07kin1x7b2ahzwd0";

  meta = with lib; {
    description = "A Go package that embeds static files into a binary";
    homepage = "https://github.com/GeertJohan/go.rice";
    license = licenses.bsd2;
    maintainers = [ maintainers.hazel ];
  };
}
