{ config, pkgs, ... }:

{
  services.znc = let
    secrets = import ../secrets.nix;
  in
  {
    enable          = true;
    mutable         = false;
    useLegacyConfig = false;
    openFirewall    = false;

    modulePackages = [
      pkgs.zncModules.playback
      pkgs.zncModules.palaver
    ];

    config = {
      LoadModule = [ "playback" "palaver" "adminlog" ]; # Write access logs to ~znc/moddata/adminlog/znc.log.

      Listener.l.SSL = false;

      User.kevin = {
        Admin = true;

        Pass.password = {
          Method = "sha256";
          Hash = secrets.znc-hash-password;
          Salt = secrets.znc-salt;
        };

        Network.freenode = {
          Server = "chat.freenode.net +6697 ${secrets.znc-freenode-password}";
          Chan = { "#nix-darwin" = {}; };
          Nick = "kgriffin";
          LoadModule = [ "nickserv" ];
          JoinDelay = 2;
        };

      };
    };
  };


  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    appendConfig = ''
      stream {

      upstream znc {
        server [::1]:5000;
      }

      server {
        listen      5001 ssl;
        listen      [::]:5001 ssl;

        ssl_certificate ${config.security.acme.certs."znc.kevin.jp".directory}/fullchain.pem;
        ssl_certificate_key ${config.security.acme.certs."znc.kevin.jp".directory}/key.pem;
        ssl_trusted_certificate ${config.security.acme.certs."znc.kevin.jp".directory}/full.pem;

        proxy_pass znc;
      }
      }
    '';

    virtualHosts."znc.kevin.jp" = {
      enableACME = true;
      forceSSL   = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 5001 ];
}
