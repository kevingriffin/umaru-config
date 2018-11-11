{ config, pkgs, environment, ... }:

{
  imports = [
    ../overlays.nix
    ../eikaiwa-servers.nix
   ];

  security.acme.certs."kevin.jp" = {
    webroot = "/var/www/challenges";
    email   = "me@kevin.jp";
  };

  security.acme.certs."dev.kevin.jp" = {
    webroot = "/var/www/challenges";
    email   = "me@kevin.jp";
  };

  boot.loader.grub.device = "/dev/vda";
  networking.hostName = "tomoyo";
  nix.buildCores = 2;

  environment.systemPackages = with pkgs; [
     eikaiwa-packages
     seeing_is_believing
     socat
  ];

   systemd.services.socat-proxy = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Start a proxy for Plex from iPv4 to iPv6";
    serviceConfig = {
      Type = "forking";
      User = "root";
      ExecStart = ''${pkgs.socat}/bin/socat -v OPENSSL-LISTEN:32400,fork,cert=/home/kevin/certs/wildcard.kevin.jp.pem,key=/home/kevin/certs/wildcard.kevin.jp.key,verify=0 TCP6:plex.kevin.jp:32400
'';
    };
 };

 networking.firewall.allowedTCPPorts = [ 32400 ];

  programs.mosh.enable = true;

  users.users.git = {
    isNormalUser = true;
    home = "/home/git";
    description = "git";
  };
}
