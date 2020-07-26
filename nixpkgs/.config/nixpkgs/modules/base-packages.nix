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
     unstablePkgs.aria2
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
     jrnl
     lego
     lsof
     unstablePkgs.neovim
     mosh
     nmap
     overmind
     pfetch
     ranger
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
     weechat
     wget
     wireshark
     unstablePkgs.youtube-dl
     yank
     unstablePkgs.ytop
     unstablePkgs.yubikey-manager
   ];
}
