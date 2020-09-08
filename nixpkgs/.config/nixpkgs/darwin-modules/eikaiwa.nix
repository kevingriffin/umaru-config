# This module only tested against nix-darwin
{ config, lib, pkgs, ... }:

with pkgs;
let
  pin =  {
    "url" = "https://releases.nixos.org/nixpkgs/nixpkgs-19.09pre185562.00ef72610c8/nixexprs.tar.xz";
    "sha256" = "0sxc6vmn7bnaw1gz7d63pdhbvn9xrn3ybqfvlpg2g19dwldx430k";
  };

  pinned_pkgs = import (builtins.fetchTarball {
     inherit (pin) url sha256;
  }) {};

  elasticsearch = pinned_pkgs.elasticsearch5;
  kibana        = pinned_pkgs.kibana5;
  elkVersion    = pinned_pkgs.elk5Version;
  elasticsearchPlugins = callPackage ../modules/eikaiwa/elasticsearch-plugins.nix { inherit elasticsearch elkVersion; };
in

{
  imports = [
    <iknow/darwin-modules>
  ];
  services = {

    kibana = {
      enable = true;
      package = kibana;
    };

    redis.enable = true;
    memcached.enable = true;

    postgresql = {
      enable = true;
      package = pkgs.postgresql_12;
      enableTCPIP = true;
      dataDir = "/usr/local/var/postgres12";
      extraConfig = ''
          fsync = off
          synchronous_commit = off
          full_page_writes = off
      '';
    };

    elasticsearch = {
      enable = true;
      listenAddress = "_local_";
      package = elasticsearch;
      plugins = elasticsearchPlugins;
      extraJavaOptions = [
        "-Xms1g"
        "-Xmx1g"
        "-Djava.security.policy=${pkgs.writeTextFile {
          name="es-security-policy";
          text=''
              grant {
                permission java.io.FilePermission "/nix/store/-", "read";
              };
          '';
        }}"
      ];
    };
    };
}
