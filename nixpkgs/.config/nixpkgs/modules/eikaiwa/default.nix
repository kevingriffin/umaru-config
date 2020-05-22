{ config, lib, pkgs, ... }:

with pkgs;
with lib;

let
  pin =  {
    "url" = "https://releases.nixos.org/nixpkgs/nixpkgs-19.09pre185562.00ef72610c8/nixexprs.tar.xz";
    "sha256" = "0sxc6vmn7bnaw1gz7d63pdhbvn9xrn3ybqfvlpg2g19dwldx430k";
  };

  pinned_pkgs = import (builtins.fetchTarball {
     inherit (pin) url sha256;
  }) {};
in
let
  elasticsearch = pinned_pkgs.elasticsearch5;
  kibana        = pinned_pkgs.kibana5;
  elkVersion    = pinned_pkgs.elk5Version;
  elasticsearchPlugins = callPackage ./elasticsearch-plugins.nix { inherit elasticsearch elkVersion; };
in

{
  services.postgresql = {
    enable = true;
    package = postgresql_11;
    dataDir = "/var/lib/postgresql/data/11.1";
    extraConfig = ''
      autovacuum = off
      unix_socket_directories = '/tmp, /run/postgresql'
      fsync = off
      synchronous_commit = off
      full_page_writes = off
    '';
  };

  systemd.services.postgresql.serviceConfig.RuntimeDirectory =
    lib.mkDefault "postgresql";

  services.elasticsearch = {
    enable = true;
    listenAddress = "_local_";
    package = elasticsearch;
    plugins = elasticsearchPlugins;
    extraJavaOptions = [
      "-Xms1g"
      "-Xmx1g"
      "-Djava.security.policy=${writeTextFile {
        name="es-security-policy";
        text=''
          grant {
            permission java.io.FilePermission "/nix/store/-", "read";
          };
        '';
      }}"
    ];
  };

  services.kibana = {
    enable = true;
    package = kibana;
  };

  services.redis.enable = true;
  services.memcached.enable = true;
}
