{ config, pkgs, lib, ... }:
let
  unstablePkgs = import <nixpkgs-unstable> {};

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
  environment.systemPackages = [
    weechat
  ];
}
