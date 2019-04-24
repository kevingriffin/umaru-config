{ config, pkgs, environment, ... }:

{
  imports = [
    ../packages/eikaiwa-servers.nix
    ../packages/ruby-development.nix
   ];

  boot.loader.grub.device = "/dev/vda";
  networking.hostName = "tomoyo";
  nix.buildCores = 2;

  environment.systemPackages = with pkgs; [
     socat
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
