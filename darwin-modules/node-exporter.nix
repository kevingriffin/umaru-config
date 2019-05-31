{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.prometheus.exporters.node;
in
{
  options = {
    services.prometheus.exporters.node = {
      enable = mkEnableOption "Prometheus Node Exporter";
    };
  };

  config = mkIf cfg.enable {
    launchd.daemons.node_exporter = {
      serviceConfig = {
        Program = "${pkgs.prometheus-node-exporter}/bin/node_exporter";
        KeepAlive = true;
        RunAtLoad = true;
        UserName = "nobody";
        GroupName = "nobody";
      };
    };
  };
}
