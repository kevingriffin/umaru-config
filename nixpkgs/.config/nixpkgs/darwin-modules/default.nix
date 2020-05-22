{ config, pkgs, ... }:

{
  imports = [
    ./nginx
    ./eikaiwa.nix
    ./direnv.nix
    ./openssh.nix
    ./ids.nix
    ./node-exporter.nix
  ];
}
