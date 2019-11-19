{ lib, fetchpatch, bundlerEnv, ruby, bundler, defaultGemConfig }:

let
  bundlerEnvWithCorrectRuby = bundlerEnv.override {
    bundler = bundler.override { ruby = ruby; };
  };

  fix-yajl = fetchpatch {
    url = "https://github.com/chef/ffi-yajl/commit/ba84d91986c2d149f0a05132401e8ad9d17dab6c.diff";
    sha256 = "0vfmdxgpcd0v2y4r5k27lnydqh3hb0zg8f24hlrddi4p7xi93815";
  };
in

bundlerEnvWithCorrectRuby rec {
  pname = "chef";

  inherit ruby;

  gemdir = ./.;

  gemConfig = defaultGemConfig // {
    ffi-yajl = attrs: {
      dontBuild = false;
      patches = (attrs.patches or []) ++ [ fix-yajl ];
    };
  };

  meta = with lib; {
    description = "A systems integration framework, built to bring the benefits of configuration management to your entire infrastructure.";
    homepage = https://www.chef.io;
    license = licenses.asl20;
    platforms = platforms.unix;
  };
}
