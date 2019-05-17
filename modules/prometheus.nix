{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts =	[
    9090 # prometheus
  ];

  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "prometheus";
        static_configs = [{
          targets = [ "localhost:9090" ];
        }];
      }
      {
        job_name = "node";
        static_configs = [{
          targets = [
            "localhost:9100"
            "files.dmm.iknow.jp:9100"
            "leeroy.dmm.iknow.jp:9100"
            "monitor-panel.dmm.iknow.jp:9100"
            "tourou.cons.org.nz:9100"
          ];
        }];
      }
    ];
  };
}

