{ config, pkgs, unstablePkgs, ... }:
{
   environment.systemPackages = with pkgs; [
     unstablePkgs._1password
     ag
     unstablePkgs.age
     unstablePkgs.aria2
     unstablePkgs.bat
     bind
     unstablePkgs.bottom
     colordiff
     unstablePkgs.gitAndTools.delta
     unstablePkgs.fd
     fish
     unstablePkgs.fzf
     # gitAndTools.diff-so-fancy
     # unstablePkgs.gitAndTools.hub
     # gitFull
     # git-lfs
     unstablePkgs.gnumake
     unstablePkgs.gnupg
     unstablePkgs.htop
     unstablePkgs.httpie
     jq
     unstablePkgs.lego
     lsof
     unstablePkgs.neovim
     unstablePkgs.nginx
     unstablePkgs.nmap
     unstablePkgs.overmind
     pfetch
     unstablePkgs.procs
     unstablePkgs.ripgrep
     rsync
     speedtest-cli
     sshpass
     stow
     tmate
     tig
     tmux
     tmux-cssh
     tree
     unzip
     unstablePkgs.xsv
     unstablePkgs.youtube-dl
     yank
     unstablePkgs.yubikey-manager
   ];
}
