{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ruby
    bundix
    seeing_is_believing
    rubocop
    direnv
    lorri
  ];

}
