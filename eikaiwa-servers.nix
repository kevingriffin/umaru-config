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
    name = "analysis-smartcn-5.6.9";
    pluginName = "analysis-smartcn";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-5.6.9.zip";
      sha256 = "1y4i9b8zxx26fjixcc7b82sxizl5hgvyqwzilgcb4cfnkap7dx8j";
    };
    meta = {};
  };

  analysis_kuromoji = esPlugin rec {
    name = "analysis-kuromoji-5.6.9";
    pluginName = "analysis-kuromoji";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-5.6.9.zip";
      sha256 = "1avwn7y80l7pajxgxa1sb66r6h2cswbls9ygml2w7090wad8b3aa";
    };
    meta = {};
  };

in

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql100;
    extraConfig = ''
      autovacuum = off
    '';
  };

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
