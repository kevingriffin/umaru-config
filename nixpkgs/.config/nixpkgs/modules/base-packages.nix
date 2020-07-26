{ config, pkgs, unstablePkgs, ... }:

let
  unstablePkgs = import<nixpkgs-unstable> { config = { allowUnfree = true; }; };

  weechat = unstablePkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = [ unstablePkgs.weechatScripts.weechat-matrix ];
      plugins = [
        (availablePlugins.python.withPackages (ps: [ unstablePkgs.weechatScripts.weechat-matrix ]))
      ];
    };
  };

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
     unstablePkgs.yubikey-manager
   ];
}
