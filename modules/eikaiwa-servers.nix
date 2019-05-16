# This module targets NixOS 19.03 and NixOS Unstable.

{ config, lib, pkgs, ... }:

with pkgs;

let
  # Copied from the internals of elasticsearch
  esPlugin = a@{
    pluginName,
    installPhase ? ''
      mkdir -p $out/config
      mkdir -p $out/plugins
      ES_HOME=$out ${elasticsearch5}/bin/elasticsearch-plugin install --batch -v file://$src
    '',
    ...
  }:
    stdenv.mkDerivation (a // {
      inherit installPhase;
      unpackPhase = "true";
      buildInputs = [ unzip ];
      meta = a.meta // {
        platforms = elasticsearch5.meta.platforms;
        maintainers = (a.meta.maintainers or []) ++ [ maintainers.offline ];
      };
  });

  analysis_smartcn = esPlugin rec {
    name = "analysis-smartcn-${elk5Version}";
    pluginName = "analysis-smartcn";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-${elk5Version}.zip";
      sha256 = {
        "5.6.9" = "1y4i9b8zxx26fjixcc7b82sxizl5hgvyqwzilgcb4cfnkap7dx8j";
        "5.6.16" = "1miijfslvj5cjb34221pky7xw6chhgbfcn48vhn3g0jfr6kcx824";
      }."${elk5Version}";
    };
    meta = {};
  };

  analysis_kuromoji = esPlugin rec {
    name = "analysis-kuromoji-${elk5Version}";
    pluginName = "analysis-kuromoji";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-${elk5Version}.zip";
      sha256 = {
        "5.6.9" = "1avwn7y80l7pajxgxa1sb66r6h2cswbls9ygml2w7090wad8b3aa";
        "5.6.16" = "0hyv856ivzrw4gzsqp55a9h2xxcnsq2l00g954r2dcx38nv69ny7";
      }."${elk5Version}";
    };
    meta = {};
  };

in

{
  # In NixOS unstable the postgres socket directory changed to
  # /run/postgresql, instead of the default /tmp. To allow mixing
  # packages from the two releases, for example in the case of having
  # unstable in user packages but 19.03 in system packages, we make
  # postgres bind on both the old and new socket locations.

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_11;
    dataDir = "/var/lib/postgresql/data/11.1";
    extraConfig = ''
      autovacuum = off
      unix_socket_directories = '/tmp, /run/postgresql'
    '';
  };

  # Unset in 19.03.
  systemd.services.postgresql.serviceConfig.RuntimeDirectory =
    lib.mkDefault "postgresql";

  services.elasticsearch = {
    enable = true;
    listenAddress = "_local_";
    package = elasticsearch5;
    plugins = [
      analysis_smartcn
      analysis_kuromoji
    ];
    extraJavaOptions = [
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
