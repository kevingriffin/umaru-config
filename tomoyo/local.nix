{ config, pkgs, environment, ... }:

{
  imports = [
    ../modules/vpn.nix
    ../modules/grafana.nix
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

  systemd.services.socat-proxy = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Start a proxy for Plex from iPv4 to iPv6";
    serviceConfig = {
      Type = "simple";
      User = "root";
      Restart = "on-failure";
      ExecStart = ''${pkgs.socat}/bin/socat -dF TCP-LISTEN:32400,fork, TCP6:umaru.kevin.jp:32400'';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 32400 ];

  kevin.iknow-vpn = {
    enable = true;
    ips    = [ "192.168.1.165/32" ];
    allowedIPs  = [ "0.0.0.0/0" ];
  };

  kevin.vpn-host = {
    enable = true;
    prefix = "2001:19f0:7001:4b5d";
    v4Base = "192.168.2";
    port = 52337;
    upstreamIfname = "ens3";

    # TODO Make this load peers from a file?
    # git repository of my public keys for wireguard and ssh and gpg
    peers = {
      "chieri" = { ordinal = 2; publicKey = "Oo9fzy6JAuvG9S1qR2ACVbUjKxPLQFsHqg4uDGQQHTY="; };
      "alpha"  = { ordinal = 3; publicKey = "erWAQdCkqatIRy1+01mhBWPg8KApwVrzNxuRGeMGvwE="; };
      "umaru"  = { ordinal = 4; publicKey = "h/trC+5Z8qbGBJtroYITQGMNUn5XQZ/JRqVR3iIH5Ro="; };
      "erika"  = { ordinal = 5; publicKey = "PBy+Msv2RZSSH9UodBa1JJ5ZsuER7rXinuW2QkzemAE="; };
    };
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
    };
  };

  users.users.git = {
    isNormalUser = true;
    home = "/home/git";
    description = "git";
  };
}
