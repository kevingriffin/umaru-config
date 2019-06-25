{ config, pkgs, options, ... }:

{
  imports = [
    ../modules/ruby-development.nix
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."haru.local.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/letsencrypt/live/haru.local.kevin.jp/fullchain.pem";
      sslCertificateKey = "/etc/nginx/letsencrypt/live/haru.local.kevin.jp/privkey.pem";
    };
  };

  services.openssh.listenAddresses = [
    { addr = "::"; port = 22; }
    { addr = "::"; port = 13579; }
  ];

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 12;
  nix.buildCores = 12;

  services.prometheus.exporters.node.enable = true;
}
