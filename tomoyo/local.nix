{ config, pkgs, environment, ... }:

{
  imports = [
    ../overlays.nix
    ../eikaiwa-servers.nix
   ];

  boot.loader.grub.device = "/dev/vda";
  networking.hostName = "tomoyo";
  nix.buildCores = 2;

  environment.systemPackages = with pkgs; [
     eikaiwa-packages
     seeing_is_believing
  ];
}
