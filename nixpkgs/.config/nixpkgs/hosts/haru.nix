{ config, pkgs, options, ... }:

{

  imports = [
    ../modules/ruby-development.nix
    ../darwin-modules/lorri.nix
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."haru.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      locations."/socket.io" = {
        proxyPass = "http://localhost:3002";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/lego/certificates/haru.kevin.jp.crt";
      sslCertificateKey = "/etc/nginx/lego/certificates/haru.kevin.jp.key";
    };
  };

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 12;
  nix.buildCores = 12;

  services.prometheus.exporters.node.enable = true;
}
