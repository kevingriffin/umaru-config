{ config, pkgs, ... }:

{
  boot.loader.grub.device = "/dev/vda";
  networking.hostName = "tomoyo";
  nix.buildCores = 2;
}
