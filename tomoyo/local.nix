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
  ];
}
