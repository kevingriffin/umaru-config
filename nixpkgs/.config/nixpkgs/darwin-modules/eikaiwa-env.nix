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
  elkVersion    = pinned_pkgs.elk5Version;
in
let
  cfg = config.lorne.eikaiwa-env;

  esPlugin = a@{
    pluginName,
    installPhase ? ''
      mkdir -p $out/config
      mkdir -p $out/plugins
      ES_HOME=$out ${elasticsearch}/bin/elasticsearch-plugin install --batch -v file://$src
    '',
    ...
  }:
    stdenv.mkDerivation (a // {
      inherit installPhase;
      unpackPhase = "true";
      buildInputs = [ unzip ];
      meta = a.meta // {
        platforms = elasticsearch.meta.platforms;
        maintainers = (a.meta.maintainers or []) ++ [ maintainers.offline ];
      };
  });

  analysis_smartcn = esPlugin rec {
    name = "analysis-smartcn-${elkVersion}";
    pluginName = "analysis-smartcn";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-${elkVersion}.zip";
      sha256 = {
        "5.6.9" = "1y4i9b8zxx26fjixcc7b82sxizl5hgvyqwzilgcb4cfnkap7dx8j";
        "5.6.16" = "1miijfslvj5cjb34221pky7xw6chhgbfcn48vhn3g0jfr6kcx824";
      }."${elkVersion}";
    };
    meta = {};
  };

  analysis_kuromoji = esPlugin rec {
    name = "analysis-kuromoji-${elkVersion}";
    pluginName = "analysis-kuromoji";
    src = fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-${elkVersion}.zip";
      sha256 = {
        "5.6.9" = "1avwn7y80l7pajxgxa1sb66r6h2cswbls9ygml2w7090wad8b3aa";
        "5.6.16" = "0hyv856ivzrw4gzsqp55a9h2xxcnsq2l00g954r2dcx38nv69ny7";
      }."${elkVersion}";
    };
    meta = {};
  };
in
{
  options = {
    lorne.eikaiwa-env.enable = lib.mkEnableOption "Eikaiwa Dev Env";
    lorne.eikaiwa-env.enableServices = lib.mkEnableOption "Eikaiwa Dev Env services";
  };

  config = lib.mkIf cfg.enable {

    services = lib.mkIf cfg.enableServices {
      redis = {
        enable = true;
      };

      postgresql = {
        enable = true;
        package = pkgs.postgresql_11;
        enableTCPIP = true;
        dataDir = "/usr/local/var/postgres11";
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
        plugins = [
          analysis_smartcn
          analysis_kuromoji
        ];
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

      # kibana
      # memcached
    };
  };
}
