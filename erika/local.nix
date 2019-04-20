{ config, pkgs, ... }:

{
  imports = [
    ../overlays.nix
    ../eikaiwa-servers.nix
   ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.loader.grub.device = "nodev";


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

  environment.systemPackages = with pkgs; [
     eikaiwa-packages
     seeing_is_believing
     yubikey-manager
     opensc
  ];

  environment.variables.OPENSC="${pkgs.opensc}/lib/pkcs11/opensc-pkcs11.so";


  hardware.cpu.intel.updateMicrocode = true;
  networking.hostName = "erika";
  networking.hostId = "a5621c46";
  services.pcscd.enable = true;

  nix.buildCores = 8;
}
