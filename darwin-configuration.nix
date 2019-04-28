{ config, pkgs, options, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  imports = [
    ./packages/base-packages.nix
    ./darwin-modules
    ./local.nix
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.fish.enable = true;

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

  # Link opensc library to location trusted by macOS ssh
  system.activationScripts.extraActivation.text = ''
    mkdir -p /usr/local/lib
    cp ${pkgs.opensc}/lib/opensc-pkcs11.so /usr/local/lib
  '';


  nix.distributedBuilds = true;

  nix.nixPath = [
    "nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs" # NixOS/nix#1865
  ] ++ options.nix.nixPath.default;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = false;
  };

}
