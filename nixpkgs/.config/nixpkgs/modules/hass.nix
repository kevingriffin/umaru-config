{ config, pkgs, unstablePkgs, ... }:
let
  pinnedPkgs = import (builtins.fetchTarball {
    url = "https://releases.nixos.org/nixpkgs/nixpkgs-21.03pre251181.dd1b7e377f6/nixexprs.tar.xz";
    sha256 = "1xr5v42ww1wq6zlryxwnk4q80bh47zrnl575jl11npqbrzci52w1";
  }) {};
in
{
  imports = [
    (builtins.fetchGit {
      url = "https://github.com/thefloweringash/hass_ir_adapter";
      ref = "master";
      rev = "3ad4405119cc10b055dd9d5945c4f291e0f714ae";
    } + "/nix/module.nix")
  ];

  security.acme.email = "me@kevin.jp";
  security.acme.acceptTerms = true;

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."hass.kevin.jp" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
        proxyWebsockets = true;
      };
    };
    virtualHosts."mqtt.kevin.jp" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:1883";
        proxyWebsockets = true;
      };
    };
  };

  services.mosquitto = let
    secrets = import ../secrets.nix;
  in
  {
    enable = true;
    host = "0.0.0.0";
    allowAnonymous = true;
    checkPasswords = true;
    ssl = {
      enable = false;
    };

    # Anyone can read
    aclExtraConf = ''
      topic read $SYS/#
      topic read homie/#
      topic read ir/#
      topic read sht/#
      topic read homeassistant/#
    '';

    users.esp1 = {
      acl = [
        "pattern read ir/%c/send"
        "pattern readwrite sht/%c/#"
      ];
      hashedPassword = secrets.mosquitto-adapter-hashed-password;
    };

    users.esp2 = {
      acl = [
        "pattern read ir/%c/send"
        "pattern readwrite sht/%c/#"
      ];
      hashedPassword = secrets.mosquitto-adapter-hashed-password;
    };

    users.esp3 = {
      acl = [
        "pattern read ir/%c/send"
        "pattern readwrite sht/%c/#"
      ];
      hashedPassword = secrets.mosquitto-adapter-hashed-password;
    };


    users.hass = {
      acl = [
        "topic readwrite homeassistant/#"
        "topic read homie/#"
        "topic read sht/#"
        "topic read tasmota/#"
      ];
      hashedPassword = secrets.mosquitto-hass-ir-hashed-password;
    };

    users.hass_ir_adapter = {
      acl = [
        "topic readwrite homeassistant/#"
        "topic readwrite ir/#"
        "topic read sht/#"
        "topic read homie/#"
        "topic readwrite tasmota/#"
      ];
      hashedPassword = secrets.mosquitto-hass-ir-hashed-password;
    };

    users.tasmota = {
      acl = [
        "topic readwrite homeassistant/#"
        "pattern readwrite tasmota/%c/#"
      ];
      hashedPassword = secrets.mosquitto-hass-ir-hashed-password;
    };
  };

  services.home-assistant = let
    withoutTests = pkg: pkg.overrideAttrs (attrs: {
      doCheck = false;
      doInstallCheck = false;
    });

    hap_python = pythonPackages: pythonPackages.callPackage ./packages/hap_python.nix { };
    gatt       = pythonPackages: pythonPackages.callPackage ./packages/gatt_python.nix { };
    fnvhash    = pythonPackages: pythonPackages.callPackage ./packages/fnvhash-python.nix { };
    pysesame2  = pythonPackages: pythonPackages.callPackage ./packages/pysesame2_python.nix { };
    bravia_tv  = pythonPackages: pythonPackages.callPackage ./packages/bravia_tv_python.nix { };
    aiohomekit = pythonPackages: pythonPackages.callPackage ./packages/aiohomekit_python.nix { };
    base36     = pythonPackages: pythonPackages.callPackage ./packages/base36_python.nix { };

    hassPkg = withoutTests (pinnedPkgs.home-assistant.override {
      extraPackages = ps: with ps; [
        xmltodict pexpect pyunifi paho-mqtt (hap_python ps)
        netdisco  (pysesame2 ps) (bravia_tv ps) (gatt ps)
        (aiohomekit ps) (base36 ps) (fnvhash ps) pkgs.ffmpeg
        pythonPackages.ha-ffmpeg  pythonPackages.aiohttp pythonPackages.hass-nabucasa
      ];
    });

    secrets = import ../secrets.nix;
  in
  {
    enable = true;
    package = hassPkg;
    autoExtraComponents = false;
    config = {
      homeassistant = {
        name = "Home";
        latitude = 35.653063;
        longitude = 139.669062;
        elevation = 33;
        unit_system = "metric";
        time_zone = "Asia/Tokyo";

        customize = {
          ${"media_player.sony_bravia_tv"} = {
            device_class = "tv";
            friendly_name = "Bravia";
            source_list = [
              "HDMI1/MHL"
              "HDMI2"
              "HDMI3"
              "HDMI4"
            ];
          };
        };
      };


      default_config = {};

      http = {
        base_url = "https://hass.kevin.jp";
        use_x_forwarded_for = true;
        trusted_proxies = "127.0.0.1";
      };

      discovery = {};

      media_player = [
        {
          platform = "braviatv";
          host     = "192.168.11.94";
        }
      ];

      mqtt = {
        broker = "127.0.0.1";
        username = "hass";
        password = secrets.mosquitto-password;
        discovery = true;
      };

      homekit = {
        name = "Hass Bridge";

        filter = {
          include_entities = [
            "climate.room_1_ac"
            "climate.room_2_ac"
            "climate.room_3_ac"
            "climate.family_room"
            "climate.spare_room"
            "light.room_1_lights"
            "light.room_2_lights"
            "light.room_3_lights"
            "lock.front_top"
            "media_player.sony_bravia_tv"
          ];
        };
      };

      lock = [
        {
          platform = "sesame";
          api_key = secrets.sesame-token;
        }
      ];

      sensor = [
        {
          platform = "mqtt";
          name = "Room 1 Temperature";
          state_topic = "sht/esp1/temp";
          unit_of_measurement = "°C";
          device_class = "temperature";
        }
        {
          platform = "mqtt";
          name = "Room 1 Humidity";
          state_topic = "sht/esp1/rh";
          unit_of_measurement = "%";
          device_class = "humidity";
        }
        {
          platform = "mqtt";
          name = "Room 2 Temperature";
          state_topic = "sht/esp2/temp";
          unit_of_measurement = "°C";
          device_class = "temperature";
        }
        {
          platform = "mqtt";
          name = "Room 2 Humidity";
          state_topic = "sht/esp2/rh";
          unit_of_measurement = "%";
          device_class = "humidity";
        }
        {
          platform = "mqtt";
          name = "Room 3 Temperature";
          state_topic = "sht/esp3/temp";
          unit_of_measurement = "°C";
          device_class = "temperature";
        }
        {
          platform = "mqtt";
          name = "Room 3 Humidity";
          state_topic = "sht/esp3/rh";
          unit_of_measurement = "%";
          device_class = "humidity";
        }
      ];

      group = {};
      automation = {};
      script = {};
    };
  };

  services.hass_ir_adapter = let
    secrets = import ../secrets.nix;
  in
  {
    enable = true;
    config = ''
      mqtt:
        broker: tcp://127.0.0.1:1883
        username: hass_ir_adapter
        password: ${secrets.mosquitto-password}
      emitters:
        - id: esp1
          type: irblaster
          topic: ir/esp1/send
        - id: esp2
          type: irblaster
          topic: ir/esp2/send
        - id: esp3
          type: irblaster
          topic: ir/esp3/send
        - id: tasmota_ir1
          type: tasmota
          topic: tasmota/ir1/cmnd
        - id: tasmota_ir2
          type: tasmota
          topic: tasmota/ir2/cmnd
      aircons:
        - id: room_1_ac
          name: "Room 1 AC"
          emitter: esp1
          type: mitsubishi_rh101
          temperature_topic: sht/esp1/temp
        - id: room_2_ac
          name: "Room 2 AC"
          emitter: esp2
          type: mitsubishi_rh101
          temperature_topic: sht/esp2/temp
        - id: room_3_ac
          name: "Room 3 AC"
          emitter: esp3
          type: mitsubishi_rh101
          temperature_topic: sht/esp3/temp
        - id: family_room_ac
          name: "Family Room"
          emitter: tasmota_ir1
          type: tasmota_hvac
          temperature_topic: tasmota/ir1/tele/SENSOR
          temperature_template: |-
            {{ value_json['SHT3X-0x45'].Temperature }}
          vendor: MITSUBISHI_AC
        - id: spare_room_ac
          name: "Spare Room"
          emitter: tasmota_ir2
          type: tasmota_hvac
          temperature_topic: tasmota/ir2/tele/SENSOR
          temperature_template: |-
            {{ value_json['SHT3X-0x45'].Temperature }}
          vendor: MITSUBISHI_AC
      lights:
        - id: room_1_lights
          name: "Room 1 Lights"
          type: daiko
          emitter: esp1
          channel: 1
        - id: room_2_lights
          name: "Room 2 Lights"
          type: daiko
          emitter: esp2
          channel: 1
        - id: room_3_lights
          name: "Room 3 Lights"
          type: daiko
          emitter: esp3
          channel: 1
    '';
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    80 443     # nginx
    1883       # mqtt
    8123 51827 # home-assistant
  ];

  networking.firewall.allowedUDPPorts = [
    5353 # home-assistant
  ];
}
