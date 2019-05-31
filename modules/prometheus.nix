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
            "erika.vm.kevin.jp:9100"
            "umaru.kevin.jp:9100"
            "haru.kevin.jp:9100"
            "reina.kevin.jp:9100"
          ];
        }];
      }
    ];
  };
}

