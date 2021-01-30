{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts =	[
    8448
  ];

  services.postgresql.enable = true;

  security.acme.certs = {
    "matrix.kevin.jp" = {
      postRun = "systemctl reload nginx.service; systemctl restart matrix-synapse.service";
    };
  };

  users.users.matrix-synapse = {
    extraGroups  = [ "nginx" ];
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."matrix.kevin.jp" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:8008";
      };
    };
  };

  services.matrix-synapse = let
    secrets = import ../secrets.nix;
  in
  {
    enable = true;
    server_name = "matrix.kevin.jp";
    registration_shared_secret = secrets.matrix-synapse-registration-secret;
    public_baseurl = "https://matrix.kevin.jp/";
    tls_certificate_path = "${config.security.acme.certs."matrix.kevin.jp".directory}/cert.pem";
    tls_private_key_path = "${config.security.acme.certs."matrix.kevin.jp".directory}/key.pem";
    database_type = "psycopg2";
    database_args = {
      database = "matrix-synapse";
    };
    listeners = [
      {
        bind_address = "";
        port = 8448;
        resources = [
          { compress = true; names = [ "client" "webclient" ]; }
          { compress = false; names = [ "federation" ]; }
        ];
        tls = true;
        type = "http";
        x_forwarded = false;
      }
      {
        bind_address = "127.0.0.1";
        port = 8008;
        resources = [
          { compress = true; names = [ "client" "webclient" ]; }
        ];
        tls = false;
        type = "http";
        x_forwarded = true;
      }
    ];
    extraConfig = ''
      max_upload_size: "100M"
    '';
  };
}

