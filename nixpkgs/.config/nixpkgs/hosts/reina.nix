{ config, pkgs, unstablePkgs, ... }:

{
  imports = [
    (import ../modules/base-packages.nix { inherit config pkgs unstablePkgs; })
    (import ../modules/ruby-development.nix { inherit config pkgs unstablePkgs; })
  ];


  environment.systemPackages = with pkgs; [
    gitAndTools.diff-so-fancy
    unstablePkgs.gitAndTools.hub
    gitFull
    git-lfs
    id3v2
    pythonPackages.eyeD3
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

  nix.maxJobs = 4;
  nix.buildCores = 3;
}
