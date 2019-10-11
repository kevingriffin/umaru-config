{ config, pkgs, options, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  imports = [
    ./modules/base-packages.nix
    ./darwin-modules/eikaiwa-env.nix
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
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
        source (fzf-share)/key-bindings.fish
    '';
  };
  # Set up fzf to go through hidden files
  # and use a fast rg backend
  environment.variables.FZF_DEFAULT_COMMAND = "rg --files --hidden -g='!.git'";
  environment.variables.FZF_CTRL_T_COMMAND  = "rg --files --hidden -g='!.git'";

  programs.bash.enable = false;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };

  nixpkgs.overlays = [
    (import ./overlays/packages.nix)
  ];

  # Andrew's Eikaiwa server configuration (redis, postgres, elasticsearch)
  lorne.eikaiwa-env = {
    enable = true;
    enableServices = true;
  };

  # Use neovim as default editor
  environment.variables.EDITOR = "nvim";

  # Make gpg always request password at terminal
  environment.variables.PINENTRY_USER_DATA = "USE_CURSES=1";


  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  services.openssh = {
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
  };

  nix.distributedBuilds = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = false;
  };

}
