{ config, pkgs, options, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  imports = [
    ./modules/base-packages.nix
    ./darwin-modules
    ./local.nix
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Make sure fish is $SHELL
  programs.fish.enable = true;
  programs.bash.enable = false;

  nixpkgs.overlays = [
    (import ./overlays/packages.nix)
  ];

  # Andrew's Eikaiwa server configuration (redis, postgres, elasticsearch)
  lorne.eikaiwa-env = {
    enable = true;
    enableServices = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  services.openssh = {
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
  };

  nix.distributedBuilds = true;

  nix.nixPath = [
    "nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs" # NixOS/nix#1865
  ] ++ options.nix.nixPath.default;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = false;
  };

}
