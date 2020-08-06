{ config, pkgs, unstablePkgs, ... }:

{

  imports = [
    (import ../modules/ruby-development.nix { inherit config pkgs unstablePkgs; })
    (import ../modules/weechat.nix { inherit config; pkgs = unstablePkgs; })
    ../darwin-modules/lorri.nix
  ];


  environment.systemPackages = with pkgs; [
     id3v2
     pythonPackages.eyeD3
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."haru.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      locations."/socket.io" = {
        proxyPass = "http://localhost:3002";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/lego/certificates/haru.kevin.jp.crt";
      sslCertificateKey = "/etc/nginx/lego/certificates/haru.kevin.jp.key";
    };
  };

  services.prometheus.exporters.node.enable = true;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 12;
  nix.buildCores = 12;

}
