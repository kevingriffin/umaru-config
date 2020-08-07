{ config, pkgs, unstablePkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     unstablePkgs._1password
     ag
     age
     unstablePkgs.aria2
     unstablePkgs.bat
     bind
     colordiff
     unstablePkgs.gitAndTools.delta
     direnv
     unstablePkgs.diskonaut
     fd
     fzf
     gitAndTools.diff-so-fancy
     unstablePkgs.gitAndTools.hub
     gitFull
     git-lfs
     unstablePkgs.gitAndTools.gitui
     gnumake
     gnupg
     hex
     htop
     httpie
     jq
     jrnl
     lego
     lsof
     unstablePkgs.neovim
     unstablePkgs.nginx
     mosh
     nmap
     nomino
     overmind
     pfetch
     procs
     ranger
     ripgrep
     rsync
     speedtest-cli
     sshpass
     stow
     tcpdump
     unstablePkgs.tmate
     tig
     tmux
     tmux-cssh
     tree
     unzip
     wget
     wireshark
     unstablePkgs.xsv
     unstablePkgs.youtube-dl
     yank
     unstablePkgs.ytop
     unstablePkgs.yubikey-manager
   ];
}
