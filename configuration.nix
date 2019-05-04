# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/base-packages.nix
    ./local.nix
  ];

  boot.cleanTmpDir = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };


  nix.useSandbox = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import ./overlays/packages.nix)
  ];


  environment.systemPackages = with pkgs; [
    borgbackup
    unstablePkgs.certbot
    gnupg
    traceroute
    usbutils
  ];

  # Use neovim as default editor
  environment.variables.EDITOR = "nvim";

  programs.mtr.enable     = true;
  programs.mosh.enable    = true;
  programs.fish.enable    = true;
  programs.ssh.startAgent = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    permitRootLogin = "no";
  };

  networking.firewall = {
    allowPing = true;
    rejectPackets = true;
    allowedTCPPorts = [ 3000 ] ;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kevin = {
    isNormalUser = true;
    home = "/home/kevin";
    description = "Kevin Griffin";
    extraGroups = [ "wheel" ];
    uid = 1000;
  };

  users.defaultUserShell = "/run/current-system/sw/bin/fish";


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
