{ config, pkgs, unstablePkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ruby
    seeing_is_believing
    rubocop
  ];

}
