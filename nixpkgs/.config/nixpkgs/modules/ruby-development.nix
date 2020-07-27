{ config, pkgs, unstablePkgs, ... }:

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
