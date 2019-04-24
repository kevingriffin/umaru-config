{ lib, bundlerEnv, ruby, bundler }:

let
  bundlerEnvWithCorrectRuby = bundlerEnv.override {
    bundler = bundler.override { ruby = ruby; };
  };
in

bundlerEnvWithCorrectRuby rec {
  pname = "chef";

  inherit ruby;

  gemdir = ./.;

  meta = with lib; {
    description = "A systems integration framework, built to bring the benefits of configuration management to your entire infrastructure.";
    homepage = https://www.chef.io;
    license = licenses.asl20;
    platforms = platforms.unix;
  };
}
