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
     httpie
     httpie
     irssi
     jq
     lsof
     neovim
     nmap
     opensc
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
