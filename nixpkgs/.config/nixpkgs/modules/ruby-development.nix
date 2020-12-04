{ config, pkgs, unstablePkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ruby
    bundix
    seeing_is_believing
    rubocop
  ];

}
