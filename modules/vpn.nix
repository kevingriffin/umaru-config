{ config, lib, pkgs, ... }:

with lib;

let
  kevin-cfg = config.kevin;
  vpnSubmodule = with lib.types; submodule {
    options = {
      enable = mkEnableOption "the vpn";
      ips    = mkOption { type = listOf str; };
    };
  };

  sharedConfig = { interface, name, publicKey, endpoint, ips }: {
    environment.etc."netns/${name}/resolv.conf".text = ''
      nameserver 1.0.0.1
      nameserver 1.1.1.1
    '';

    networking.wireguard.interfaces."${interface}" = {
      namespace = name;
      privateKeyFile = "/etc/nixos/wireguard-private-key";
      postSetup = ''
        ${pkgs.iproute}/bin/ip -n ${name} link set ${interface} mtu ${toString (1420 - 20)}
      '' ;
      inherit ips;
      peers = [ {
        inherit publicKey endpoint;
        allowedIPs = [
          "0.0.0.0/0"
        ];
        persistentKeepalive = 25;
      }];
    };
  };
in
{
  disabledModules = [ "services/networking/wireguard.nix" ];

  imports = [
    ../modules/wireguard.nix
  ];

  options = with lib.types; {
    kevin = {
      iknow-vpn = mkOption {
        type = vpnSubmodule;
        default = {};
      };
      home-vpn = mkOption {
        type = vpnSubmodule;
        default = {};
      };
    };
  };

  config = mkMerge [
    (mkIf kevin-cfg.iknow-vpn.enable (sharedConfig {
      name = "iknow";
      interface = "wg0";
      publicKey = "T3w2pRLJTKArHLxA4uGgG07XHv4JkGBCrilnXkpNGTs=";
      endpoint = "111.108.92.242:52336";
      inherit (kevin-cfg.iknow-vpn) ips;
    }))

    (mkIf kevin-cfg.home-vpn.enable (sharedConfig {
      name = "home";
      interface = "wg1";
      publicKey = "T3w2pRLJTKArHLxA4uGgG07XHv4JkGBCrilnXkpNGTs=";
      endpoint = "111.108.92.242:52336";
      inherit (kevin-cfg.home-vpn) ips;
    }))
  ];
}


