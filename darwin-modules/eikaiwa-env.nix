# This module only tested against nix-darwin
{ config, lib, pkgs, ... }:

let
  cfg = config.lorne.eikaiwa-env;

  checkout_dir = "/Users/kevin/code/eikaiwa_content_frontend";

  esPlugin = with pkgs; a@{
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
    src = pkgs.fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-smartcn/analysis-smartcn-5.6.9.zip";
      sha256 = "1y4i9b8zxx26fjixcc7b82sxizl5hgvyqwzilgcb4cfnkap7dx8j";
    };
    meta = {};
  };

  analysis_kuromoji = esPlugin rec {
    name = "analysis-kuromoji-5.6.9";
    pluginName = "analysis-kuromoji";
    src = pkgs.fetchurl {
      url = "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-5.6.9.zip";
      sha256 = "1avwn7y80l7pajxgxa1sb66r6h2cswbls9ygml2w7090wad8b3aa";
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
    environment.systemPackages = with pkgs; [
      eikaiwa-packages
    ];

    services = lib.mkIf cfg.enableServices {
      redis = {
        enable = true;
      };

      postgresql = {
        enable = true;
        package = pkgs.postgresql_10;
        enableTCPIP = true;
        dataDir = "/usr/local/var/postgres10";
        extraConfig = ''
          fsync = off
          synchronous_commit = off
          full_page_writes = off
        '';
      };

      elasticsearch = {
        enable = true;
        listenAddress = "_local_";
        package = pkgs.elasticsearch5;
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

      nginx = {
        enable = true;
        virtualHosts.default = {
          default = true;
          forceSSL = true;
          globalRedirect = "localhost.devdomain.name:3000";
          sslCertificate = "${checkout_dir}/config/dev-cert.pem";
          sslCertificateKey = "${checkout_dir}/config/dev-key.pem";
        };
      };

      # kibana
      # memcached
    };
  };
}
