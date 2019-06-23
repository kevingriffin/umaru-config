{ config, pkgs, ... }:

let

  withoutTests = pkg: pkg.overrideAttrs (attrs: {
    doCheck = false;
    doInstallCheck = false;
  });

  hap_python = pythonPackages: pythonPackages.callPackage ../overlays/packages/hap_python.nix { };

  hassPkg = withoutTests (pkgs.home-assistant.override {
    extraPackages = ps: with ps; [
      xmltodict pexpect pyunifi paho-mqtt (hap_python ps)
      netdisco
    ];
  });
in

{
  networking.firewall.allowedTCPPorts = [ 8123 51827 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  ### home assistant itself
  environment.systemPackages = with pkgs; [ vim hassPkg ];

  services.home-assistant = {
    enable = true;
    package = hassPkg;
      # Prevents using yaml features, like !secret
      # and the packaging stuff doesn't work anyway
      # config = hassConfig;
    };

  services.mosquitto.users.hass = {
    acl = [
      "topic readwrite homeassistant/#"
      "topic read homie/#"
    ];
    hashedPassword = "$6$iKdrL7yVSTPbK+IH$q6D9vmmL6bmbxb8W9i7ATSZD6w7ONtG/tviBW71QQWGBHe3FMke/uO7vONmDBA5If2SZ+BhTLn8y+fnnTTXXUg==";
  };

  ### hass_ir_adapter

  imports = [
    (builtins.fetchGit {
      url = "https://github.com/thefloweringash/hass_ir_adapter";
      rev = "a0bfc59f6b03525004607afa7ab008a243f52848";
    } + "/nix/module.nix")
  ];

  services.hass_ir_adapter.enable = true;
  services.hass_ir_adapter.config = ''
    mqtt:
      broker: tcp://localhost:1883
      username: hass_ir_adapter
      password: VighEadd

    emitters:
      - id: ir_computer
        type: irkit
        endpoint: http://192.168.11.90

    lights:
      - id: computers
        name: "Computer Lights"
        type: daiko
        channel: 1
        emitter: ir_computer
  '';

  services.mosquitto.users.hass_ir_adapter = {
    acl = [
      "topic readwrite homeassistant/#"
      "topic readwrite ir/#"
      "topic read homie/#"
    ];
    hashedPassword = "$6$ch0tw9hBugLVRVrj$Vph5Mp3mpQtMf9IMrlqUyVFEvLWHHcEMyXNZek7aj7AE+mgZTSpWZj8K4r3C6vGb4F7kkS8eJb/YfoH4jzlNYA==";
  };

}
