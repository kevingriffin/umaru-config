{ config, pkgs, ... }:

{
  imports = [
    ./nginx
    ./openssh.nix
    ./ids.nix
  ];
}
