{ config, pkgs, ... }:

{
  services.postgresql.enable = true;

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."rss.kevin.jp" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8055";
      };
    };
  };

  services.miniflux =
  {
    enable = true;
    config = {
      LISTEN_ADDR = "localhost:8055";
    };
    adminCredentialsFile = "/etc/nixos/miniflux-admin-credentials";
  };
}

