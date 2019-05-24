{ config, pkgs, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> {};
in
{
   environment.systemPackages = with pkgs; [
     _1password
     ag
     bind
     unstablePkgs.certbot
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
     httpie
     irssi
     jq
     lsof
     neovim
     nmap
     rsync
     sshpass
     tcpdump
     tig
     tmux
     tree
     unzip
     wget
     wireshark
     unstablePkgs.youtube-dl
     yubikey-manager
   ];
}
