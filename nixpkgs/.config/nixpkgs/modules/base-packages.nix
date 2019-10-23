{ config, pkgs, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
   environment.systemPackages = with pkgs; [
     _1password
     ag
     bind
     colordiff
     direnv
     fzf
     gitAndTools.diff-so-fancy
     gitAndTools.hub
     gitFull
     gnumake
     gnupg
     htop
     httpie
     id3v2
     irssi
     jq
     lego
     lsof
     nightly-neovim
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
     yubikey-manager
   ];
}
