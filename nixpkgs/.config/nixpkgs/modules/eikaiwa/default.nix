{ config, lib, pkgs, ... }:

with pkgs;
with lib;

let
  elasticsearch = elasticsearch5;
  elkVersion    = elk5Version;
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
    package = elasticsearch5;
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
    package = kibana5;
  };

  services.redis.enable = true;
  services.memcached.enable = true;
}
