{ config, pkgs, ... }:
{
  services.zigbee2mqtt = {
    enable = true;
    config = {
      homeassistant = config.services.home-assistant.enable;
      permit_join   = true;
      serial        = {
        port = "/dev/ttyACM0";
      };
    };
  };
}
