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
     httpie
     httpie
     irssi
     jq
     lsof
     neovim
     nmap
     rsync
     tcpdump
     tig
     tmux
     tree
     wget
     wireshark
     unstablePkgs.youtube-dl
     unzip
     yubikey-manager
   ];
}
