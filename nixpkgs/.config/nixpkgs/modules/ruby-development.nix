{ stdenv, lib, config, pkgs, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
  environment.systemPackages = with pkgs; [
    unstablePkgs.ruby
    bundix
    seeing_is_believing
    rubocop
    direnv
    lorri
  ];

}
