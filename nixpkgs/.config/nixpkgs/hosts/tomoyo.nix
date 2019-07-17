{ config, pkgs, environment, ... }:

{
  imports = [
    ../modules/preboot-ssh.nix
    ../modules/vpn.nix
    ../modules/prometheus.nix
   ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";
  networking.hostName = "tomoyo";
  nix.buildCores = 2;

  boot.initrd.luks.devices = [{
    name = "rootdev";
    device = "/dev/vda2";
    preLVM = true;
  }];

  environment.systemPackages = with pkgs; [
     socat
     iknow-devops
     iknow-devops-legacy
     phraseapp_updater
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = false;
  };

  kevin.preboot-ssh = {
    enable = true;
    identityFile = "/home/kevin/identities/ssh.json";
  };

  kevin.iknow-vpn = {
    enable = true;
    ips    = [ "192.168.1.165/32" ];
    allowedIPs  = [ "0.0.0.0/0" ];
  };

  kevin.vpn-host = {
    enable = true;
    prefix = "2001:19f0:7001:4b5d:1000";
    prefixLength = 68;
    v4Base = "192.168.2";
    port = 52337;
    upstreamIfname = "eth0";

    # TODO Make this load peers from a file?
    # git repository of my public keys for wireguard and ssh and gpg
    peers = {
      "chieri" = { ordinal = 2; publicKey = "Oo9fzy6JAuvG9S1qR2ACVbUjKxPLQFsHqg4uDGQQHTY="; };
      "alpha"  = { ordinal = 3; publicKey = "erWAQdCkqatIRy1+01mhBWPg8KApwVrzNxuRGeMGvwE="; };
      "umaru"  = { ordinal = 4; publicKey = "h/trC+5Z8qbGBJtroYITQGMNUn5XQZ/JRqVR3iIH5Ro="; };
      "erika"  = { ordinal = 5; publicKey = "PBy+Msv2RZSSH9UodBa1JJ5ZsuER7rXinuW2QkzemAE="; };
      "haru"   = { ordinal = 6; publicKey = "fLyslIOYAC5kPCrolf/2yqlIQR3vDltnFiM+H6Kk00g="; };
    };
  };


  services.grafana = {
    enable = true;
    port = 4000;
    addr = "[::]";
    domain = "tomoyo.kevin.jp";
    rootUrl = "https://tomoyo.kevin.jp/grafana";
    auth.anonymous.enable = false;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."tomoyo.kevin.jp" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
      };
      locations."/prometheus" = {
        proxyPass = "http://localhost:9090";
        extraConfig = ''
          auth_basic           "Prometheus";
          auth_basic_user_file /etc/nixos/.htpasswd;
          '';
      };
      locations."/grafana" = {
        proxyPass = "http://localhost:4000";
        extraConfig = ''
          rewrite  ^/grafana/(.*)  /$1 break;
          '';
      };
    };
  };

  users.users.git = {
    isNormalUser = true;
    home = "/home/git";
    description = "git";
  };
}
