{ config, pkgs, ... }:

{
  imports =
    [
      ../nix-mape/nixos-modules
      ../modules/router.nix
      ../modules/dns.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "pleinair"; # Define your hostname.

  time.timeZone = "Asia/Tokyo";

  services.openssh.enable = true;

  services.prometheus.exporters.node = {
    enable = true;
    openFirewall = true;
  };

  virtualisation.vmware.guest = {
    enable = true;
    headless = true;
  };

   users.users.kevin = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
   };

  system.stateVersion = "20.03";

}
