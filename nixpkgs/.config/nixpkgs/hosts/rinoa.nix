{ config, pkgs, unstablePkgs, ... }:

let
  unstablePkgs   = import<nixpkgs-unstable> {};
  nativePackages = import "/Users/kevin/src/nixpkgs" { localSystem = "aarch64-darwin"; };
in
{

  imports = [
    (import ../modules/base-packages.nix { inherit config unstablePkgs; pkgs = nativePackages; })
    (import ../modules/ruby-development.nix { inherit config unstablePkgs; pkgs = nativePackages; })
    (import ../modules/weechat.nix { inherit config; pkgs = unstablePkgs; })
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    fish = nativePackages.fish;
  };

  nix.extraOptions = "extra-platforms = x86_64-darwin aarch64-darwin";

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts."rinoa.kevin.jp" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
      locations."/socket.io" = {
        proxyPass = "http://localhost:3002";
        proxyWebsockets = true;
      };
      sslCertificate = "/etc/nginx/lego/certificates/rinoa.kevin.jp.crt";
      sslCertificateKey = "/etc/nginx/lego/certificates/rinoa.kevin.jp.key";
    };
  };

  services.prometheus.exporters.node.enable = true;

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs    = 8;
  nix.buildCores = 8;

}
