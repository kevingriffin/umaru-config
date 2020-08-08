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
    paths = [/var/lib/hass];
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

    # TODO Make this load peers from a file?
    # git repository of my public keys for wireguard and ssh and gpg
    peers = {
      "chieri" = { ordinal = 2; publicKey = "Oo9fzy6JAuvG9S1qR2ACVbUjKxPLQFsHqg4uDGQQHTY="; };
      "alpha"  = { ordinal = 3; publicKey = "erWAQdCkqatIRy1+01mhBWPg8KApwVrzNxuRGeMGvwE="; };
      "umaru"  = { ordinal = 4; publicKey = "lbPCBtO7qz7pTPreg7+O1DW8YRJAQGolheknwmyD5TE="; };
      "erika"  = { ordinal = 5; publicKey = "PBy+Msv2RZSSH9UodBa1JJ5ZsuER7rXinuW2QkzemAE="; };
      "haru"   = { ordinal = 6; publicKey = "fLyslIOYAC5kPCrolf/2yqlIQR3vDltnFiM+H6Kk00g="; };
    };
  };

  system.stateVersion = "19.03";
}
