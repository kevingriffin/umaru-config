{ config, pkgs, options, ... }:

{
  imports = [
    ../modules/ruby-development.nix
  ];


  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."reina.local.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/lego/certificates/reina.local.kevin.jp.crt";
      sslCertificateKey = "/etc/nginx/lego/certificates/reina.local.kevin.jp.key";
    };
  };

  services.prometheus.exporters.node.enable = true;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 3;
}
