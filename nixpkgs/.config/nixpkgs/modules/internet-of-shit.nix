{ config, lib, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts =	[
    1883 # mqtt
  ];

  services.mosquitto = {
    enable = true;
    host = "0.0.0.0";

    allowAnonymous = true;
    checkPasswords = false;

    # Anyone can read
    aclExtraConf = ''
      topic read $SYS/#
      topic read ir/#
      topic read homeassistant/#
    '';

    users.homebridge = {
      acl = [
        "topic readwrite ir/#"
        "topic read homie/#"
      ];
      hashedPassword = "$6$eEBSIrXRZOBRaEWD$8FQR2iVORDJczmKq6OEvIs/7wyobvHMQKuiSXSsIOrV19sOCF8+c6PzFoi0IIv+7bF5yk5PWP4g0uaBghywf1Q==";
    };

    users.irsender = {
      acl = [ "pattern read ir/%c/send" ];
      hashedPassword = "$6$pTH5YaLp/f8OG3R7$FYPrcSP8bX4NmxY55V2IhiPyGBEx9C3fEboXPQb9UfMkFpcV6XPTiEz6VWf/Ha4eBEKtcVJu68Fi/mOKIggqDA==";
    };
  };

}
