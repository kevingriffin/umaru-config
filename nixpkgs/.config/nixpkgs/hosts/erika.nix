{ config, pkgs, ... }:

{
  imports = [
    ../modules/preboot-ssh.nix
    ../modules/eikaiwa
    ../modules/ruby-development.nix
    ../modules/swift.nix
    ../modules/vpn.nix
   ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.enableUnstable = true;
  boot.loader.grub.device = "nodev";


  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."erika.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/lego/certificates/erika.kevin.jp.crt";
      sslCertificateKey = "/etc/nginx/lego/certificates/erika.kevin.jp.key";
    };
    virtualHosts."erika.local.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/lego/certificates/erika.local.kevin.jp.crt";
      sslCertificateKey = "/etc/nginx/lego/certificates/erika.local.kevin.jp.key";
    };
  };

  boot.initrd.luks.devices = [
    {
      name = "root1";
      device = "/dev/disk/by-uuid/8537440e-66a3-4696-a9cc-69493e8e97f9";
      allowDiscards = true;
    }
    {
      name = "root2";
      device = "/dev/disk/by-uuid/02be44d4-9def-47e7-95cb-413bd54130d0";
      allowDiscards = true;
    }
  ];


  boot.kernelParams = [ "nomodeset" ];

  kevin.preboot-ssh = {
    enable = true;
    identityFile = "/home/kevin/identities/ssh.json";
  };

  hardware.cpu.intel.updateMicrocode = true;

  environment.systemPackages = with pkgs; [
     phraseapp_updater
     seeing_is_believing
     yubikey-manager
     opensc
  ];


  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = true;
  };

  kevin.iknow-vpn = {
    enable = true;
    ips    = [ "192.168.1.169/32" "2001:19f0:7001:3571:c0fe:0:f00:9/128" ];
    allowedIPs  = [ "0.0.0.0/0" "::/0" ];
  };

  kevin.tomoyo-vpn = {
    enable     = true;
    ips    = [ "192.168.2.5/32" "2001:19f0:7001:4b5d:1000::5/128"];
    allowedIPs  = [ "0.0.0.0/0" "::/0" ];
  };


  system.activationScripts.userActivationScripts =
          ''
            mkdir -p /usr/lib
            cp ${pkgs.opensc}/lib/opensc-pkcs11.so /usr/lib
          '';

  environment.variables.OPENSC="/usr/lib/opensc-pkcs11.so";

  networking.hostName = "erika";
  networking.hostId = "a5621c46";
  services.pcscd.enable = true;

  system.autoUpgrade = {
    enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "Monday 03:15";
    options = "--delete-older-than 7d";
  };

  nix.buildCores = 8;
}
