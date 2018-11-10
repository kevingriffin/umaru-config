{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  boot.initrd.luks.devices = [
   {
     name = "root";
     device = "/dev/disk/by-uuid/72bba5e8-fc90-440f-b7a0-ef3d989ad7ad";
     preLVM = true;
     allowDiscards = true;
   }
  ];

  hardware.cpu.intel.updateMicrocode = true;
  networking.hostName = "umaru";

  nix.buildCores = 8;
}
