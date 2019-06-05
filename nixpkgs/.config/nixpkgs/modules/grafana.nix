{ config, lib, pkgs, ... }:

let
  grafanaPort = 4000;
in

{
  networking.firewall.allowedTCPPorts =	[
    grafanaPort
  ];

  services.grafana = {
    enable = true;
    port = grafanaPort;
    addr = "[::]";
    auth.anonymous.enable = true;
  };
}

