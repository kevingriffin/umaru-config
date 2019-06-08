{config, lib, ...}:

let
  secrets = config.secrets;

  secretsSubmodule = with lib.types; submodule {
    options = {
      pushover-token                    = mkOption { type = str; };
      pushover-user-key                 = mkOption { type = str; };
      mosquitto-user-hashed-password    = mkOption { type = str; };
      mosquitto-hass-ir-hashed-password = mkOption { type = str; };
    };
  };
in
{
  options = with lib.types; {
    secrets = mkOptions {
      type = secretsSubmodule;
      default = {};
    };
  };

  config.secrets.pushover-token                    = "";
  config.secrets.pushover-user-key                 = "";
  config.secrets.mosquitto-user-hashed-password    = "";
  config.secrets.mosquitto-hass-ir-hashed-password = "";
}

