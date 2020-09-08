{ config, pkgs, ... }:
let
  weechat = pkgs.weechat.override {
    configure = { availablePlugins, ... }: {
      scripts = [ pkgs.weechatScripts.weechat-matrix pkgs.weechatScripts.wee-slack ];
      plugins = [
        (availablePlugins.python.withPackages (ps: [ pkgs.weechatScripts.weechat-matrix pkgs.weechatScripts.wee-slack ]))
      ];
    };
  };
in
{
  environment.systemPackages = [
    weechat
  ];
}
