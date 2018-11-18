{ config, pkgs, ... }:

{
  imports = [
    ../overlays.nix
    ../eikaiwa-servers.nix
   ];

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

  boot.kernelParams = [ "nomodeset" ];

  environment.systemPackages = with pkgs; [
     eikaiwa-packages
     seeing_is_believing
  ];

  hardware.cpu.intel.updateMicrocode = true;
  networking.hostName = "erika";

  nix.buildCores = 8;
}
