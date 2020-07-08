{ config, pkgs, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
  newYubikeyManagerPkgs = import (builtins.fetchGit {
    url = "https://github.com/nixos/nixpkgs";
    ref = "44fd570d7344fb31d7dd92a42d6e1ef872b5f76b";
  }) {};
in
{
   environment.systemPackages = with pkgs; [
     unstablePkgs._1password
     ag
     age
     bind
     colordiff
     direnv
     fzf
     gitAndTools.diff-so-fancy
     unstablePkgs.gitAndTools.hub
     gitFull
     git-lfs
     gnumake
     gnupg
     htop
     httpie
     id3v2
     irssi
     jq
     lego
     lsof
     unstablePkgs.neovim
     mosh
     nmap
     overmind
     ripgrep
     rsync
     speedtest-cli
     sshpass
     stow
     tcpdump
     tig
     tmux
     tmux-cssh
     tree
     unzip
     wget
     weechat
     wireshark
     unstablePkgs.youtube-dl
     yank
     newYubikeyManagerPkgs.yubikey-manager
   ];
}
