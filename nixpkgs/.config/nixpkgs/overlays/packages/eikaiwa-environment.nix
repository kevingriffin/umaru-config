{ lib, pkgs, buildEnv, yarn, overmind, ruby_2_6, bundler, nodejs-10_x ? null }:

with pkgs;

let
  pkgsNewEnough = (lib.versionAtLeast yarn.version "1.10.0") && (nodejs-10_x != null);

  webpkgs = if pkgsNewEnough
    then { inherit yarn nodejs-10_x bundler; }
    else builtins.trace "Using <nixpkgs-unstable> channel for web packages"
         (import <nixpkgs-unstable> {});
in

let
  nodejs  = webpkgs.nodejs-10_x;
  yarn    = webpkgs.yarn.override { inherit nodejs; };
  bundler = webpkgs.bundler;

  ruby = ruby_2_6.overrideAttrs (attrs: {
    patches = (attrs.patches or []) ++ [
      # RubyGems has a regression where you can no longer build certain gems
      # outside their directory. Until this is merged, patch from the pull
      # request.
      (fetchpatch {
        url = https://patch-diff.githubusercontent.com/raw/rubygems/rubygems/pull/2596.patch;
        sha256 = "0m1s5brd30bqcr8v99sczihm83g270philx83kkw5bpix462fdm3";
      })
    ];
  });
in

  buildEnv {
    name = "eikaiwa-packages";
    paths = [
      nodejs
      yarn
      overmind
      ruby
    ];
}
