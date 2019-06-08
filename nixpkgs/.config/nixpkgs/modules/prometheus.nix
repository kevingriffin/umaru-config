{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = true;
    extraFlags = [ "-web.external-url=https://tomoyo.kevin.jp/prometheus/" ];
    scrapeConfigs = [
      {
        job_name = "prometheus";
        metrics_path = "/prometheus/metrics";
        static_configs = [{
          targets = [
            "localhost:9090"
          ];
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

    rules = [
      ''
        ALERT ExporterDown
          IF up == 0
          FOR 5m
      ''
    ];

  };
}
