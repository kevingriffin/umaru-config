{ config, pkgs, unstablePkgs, ... }:

{
  imports = [
    (import ../modules/base-packages.nix { inherit config pkgs unstablePkgs; })
    (import ../modules/ruby-development.nix { inherit config pkgs unstablePkgs; })
    ../darwin-modules/eikaiwa.nix
  ];


  environment.systemPackages = with pkgs; [
    gitAndTools.diff-so-fancy
    unstablePkgs.gitAndTools.hub
    gitFull
    git-lfs
  ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."reina.local.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/lego/certificates/reina.local.kevin.jp.crt";
      sslCertificateKey = "/etc/nginx/lego/certificates/reina.local.kevin.jp.key";
    };
  };

  services.prometheus.exporters.node.enable = true;

  nix.maxJobs = 4;
  nix.buildCores = 3;
}
