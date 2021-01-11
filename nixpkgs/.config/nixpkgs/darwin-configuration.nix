{ config, pkgs, options, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{

  imports = [
    (import ./local.nix { inherit config pkgs unstablePkgs; })
    ./darwin-modules
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  nix.package                = pkgs.nix;
  services.nix-daemon.enable = true;

  programs.fish = {
    enable               = true;
    interactiveShellInit = ''
        source (fzf-share)/key-bindings.fish
    '';
    translateEnvironment = true;
  };

  programs.bash.enable = true;
  programs.zsh.enable  = true;

  # Set up fzf to go through hidden files
  # and use a fast rg backend
  environment.variables.FZF_DEFAULT_COMMAND = "rg --files --hidden -g='!.git'";
  environment.variables.FZF_CTRL_T_COMMAND  = "rg --files --hidden -g='!.git'";

  programs.gnupg.agent = {
    enable           = true;
    enableSSHSupport = false;
  };

  nixpkgs.overlays = [
    (import ./overlays/packages.nix)
  ];

  environment.variables.EDITOR = "nvim";
  # Make gpg always request password at terminal
  environment.variables.PINENTRY_USER_DATA = "USE_CURSES=1";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 3;

  services.openssh = {
    passwordAuthentication          = false;
    challengeResponseAuthentication = false;
  };

  nix = {
    distributedBuilds = true;
  };

  nixpkgs.config = {
    allowUnfree            = true;
    allowUnsupportedSystem = false;
  };

}
