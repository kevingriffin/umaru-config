{ config, pkgs, ... }:

{
  imports = [
    ../modules/borg-backup
    ../modules/hass.nix
    ../modules/vpn.nix
  ];

  boot.loader.grub.enable  = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device  = "/dev/sda"; # or "nodev" for efi only

  console.font       = "Lat2-Terminus16";
  console.keyMap     = "us";

  time.timeZone = "Asia/Tokyo";

  services.udisks2.enable = false;

  services.borgBackup = let
    secrets = import ../secrets.nix;
  in
  {
    enable = true;
    paths = [ "/var/lib/hass" ];
    excludedGlobs = [ "configuration.yaml" ];
    remoteRepo = {
      host         = "hk-s020.rsync.net";
      user         = "20504";
      path         = "flonne";
      borgPath     = "borg1";
      borgPassword = secrets.borg-password;
    };
  };

  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = true;
  };

  networking.hostName = "flonne"; # Define your hostname.
  networking.firewall.allowedTCPPorts = [ 22 17569 ];

  programs.mtr.enable = true;

  virtualisation.vmware.guest = {
    enable = true;
    headless = true;
  };

  kevin.vpn-host = {
    enable         = true;
    prefix         = "2404:7a80:32e1:6601";
    prefixLength   = 64;
    v4Base         = "192.168.2";
    port           = 50798;
    upstreamIfname = "ens192";
    neighborProxy  = false;

    peers = (builtins.fromJSON (builtins.readFile "/home/kevin/identities/wireguard-hosts.json"));
  };

  system.stateVersion = "19.03";
}
