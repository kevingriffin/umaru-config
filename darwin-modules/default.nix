{ config, pkgs, ... }:

{
  imports = [
    ./nginx
    ./eikaiwa-env.nix
    ./elasticsearch.nix
    ./direnv.nix
    ./openssh.nix
    ./ids.nix
    ./node-exporter.nix
  ];
}
