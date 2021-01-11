{ config, pkgs, ... }:

{
  services.prometheus = let
    secrets = import ../secrets.nix;
  in
  {
    alertmanager = {
      enable = true;
      configText = ''
        receivers:
          - name: pushover
            pushover_configs:
              - user_key: ${secrets.pushover-user-key}
                token: ${secrets.pushover-token}

        route:
          receiver: pushover
          group_wait: 30s
          group_interval: 5m
          repeat_interval: 4h
      '';
    };

    alertmanagers = [{
      scheme = "http";
      static_configs = [{
        targets = [ "localhost:${toString config.services.prometheus.alertmanager.port}" ];
      }];
    }];

    enable = true;
    webExternalUrl = "https://prometheus.kevin.jp/";
    scrapeConfigs = [
      {
        job_name = "prometheus";
        metrics_path = "/metrics";
        static_configs = [{
          targets = [
            "localhost:9090"
          ];
        }];
      }
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "localhost:9100"
              "pleinair.kevin.jp:9100"
            ];
          }

          {
            targets = [
              "erika.kevin.jp:9100"
              "umaru.kevin.jp:9100"
            ];
            labels =  {
              transient = "yes";
            };
          }
        ];
      }
    ];

    rules = [
      ''
        groups:
          - name: down
            rules:
              - alert: ExporterDown
                expr: up{transient!="yes"} == 0
                for: 5m
      ''
    ];
  };
}

