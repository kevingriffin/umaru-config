{ config, lib, pkgs, ... }: {
  imports = [
    (builtins.fetchGit {
      url = "https://github.com/thefloweringash/hass_ir_adapter";
      ref = "master";
      rev = "cf77c16c268504352c97bf03959bb6d45840ca0c";
    } + "/nix/module.nix")
  ];

  users.groups.ssl-cert = {
    members = [
      config.services.nginx.user
      "mosquitto"
    ];
  };

  security.acme.email = "me@kevin.jp";
  security.acme.acceptTerms = true;

  security.acme.certs = {
    "hass.kevin.jp" = {
      allowKeysForGroup = true;
      group = "ssl-cert";
      dnsProvider = "cloudflare";
      credentialsFile = "/var/secrets/cloudflare";
    };

    "mqtt.kevin.jp" = {
      allowKeysForGroup = true;
      group = "ssl-cert";
      dnsProvider = "cloudflare";
      credentialsFile = "/var/secrets/cloudflare";
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."hass.kevin.jp" = {
      forceSSL = true;
      sslCertificate    = "${config.security.acme.certs."hass.kevin.jp".directory}/cert.pem";
      sslCertificateKey = "${config.security.acme.certs."hass.kevin.jp".directory}/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
        proxyWebsockets = true;
      };
    };
    virtualHosts."mqtt.kevin.jp" = {
      forceSSL = true;
      sslCertificate    = "${config.security.acme.certs."mqtt.kevin.jp".directory}/cert.pem";
      sslCertificateKey = "${config.security.acme.certs."mqtt.kevin.jp".directory}/key.pem";
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
      enable = true;
      host = "0.0.0.0";
      cafile   = "${config.security.acme.certs."mqtt.kevin.jp".directory}/chain.pem";
      certfile = "${config.security.acme.certs."mqtt.kevin.jp".directory}/cert.pem";
      keyfile  = "${config.security.acme.certs."mqtt.kevin.jp".directory}/key.pem";
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
      ];
      hashedPassword = secrets.mosquitto-hass-ir-hashed-password;
    };

    users.hass_ir_adapter = {
      acl = [
        "topic readwrite homeassistant/#"
        "topic readwrite ir/#"
        "topic read sht/#"
        "topic read homie/#"
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
    homekit    = pythonPackages: pythonPackages.callPackage ./packages/homekit_python.nix { gatt = (gatt pythonPackages); };
    pysesame2  = pythonPackages: pythonPackages.callPackage ./packages/pysesame2_python.nix { };

    hassPkg = withoutTests (pkgs.home-assistant.override {
      extraPackages = ps: with ps; [
        xmltodict pexpect pyunifi paho-mqtt (hap_python ps)
        netdisco (homekit ps) (pysesame2 ps)
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
      };

      default_config = {};

      http = {
        base_url = "https://hass.kevin.jp";
        use_x_forwarded_for = true;
        trusted_proxies = "127.0.0.1";
      };

      discovery = {};

      mqtt = {
        broker = "localhost";
        username = "hass";
        password = secrets.mosquitto-user-hashed-password;
        discovery = true;
      };

      homekit = {
        name = "Hass Bridge";
        filter = {
          include_entities = [
            "climate.room_1_ac"
            "climate.room_2_ac"
            "climate.room_3_ac"
            "light.room_1_lights"
            "light.room_2_lights"
            "light.room_3_lights"
            "lock.front_top"
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
        broker: tcp://localhost:1883
        username: hass_ir_adapter
        password: ${secrets.mosquitto-user-hashed-password}
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
