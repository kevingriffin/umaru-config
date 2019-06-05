{ lib, bundlerEnv, ruby_2_3, bundler, defaultGemConfig }:

let
  ruby = ruby_2_3;

  publicGithubUrl = url:
    "https://github.com/" + (lib.removePrefix "git@github.com:" url);

  useGithubPublicUrl = attrs: {
    source = attrs.source // {
      url = publicGithubUrl attrs.source.url;
    };
  };

  bundlerEnvWithCorrectRuby = bundlerEnv.override {
    bundler = bundler.override { ruby = ruby; };
  };
in

bundlerEnvWithCorrectRuby rec {
  pname = "capistrano";

  inherit ruby;

  gemdir = ./.;

  gemConfig = defaultGemConfig // {
    capistrano-chef = useGithubPublicUrl;
  };

  meta = with lib; {
    description = "Remote multi-server automation tool";
    homepage = http://www.capistranorb.com/;
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
