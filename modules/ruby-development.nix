{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bundler
    bundix
    ruby
    seeing_is_believing
    rubocop
    direnv
    lorri
  ];

}
