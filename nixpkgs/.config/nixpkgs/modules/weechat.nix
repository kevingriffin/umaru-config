{ config, pkgs, ... }:
let
  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = [ pkgs.weechatScripts.weechat-matrix ];
      plugins = [
        (availablePlugins.python.withPackages (ps: [ pkgs.weechatScripts.weechat-matrix ]))
      ];
    };
  };
in
{
  environment.systemPackages = [
    weechat
  ];
}
