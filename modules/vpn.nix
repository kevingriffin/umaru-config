{ config, lib, pkgs, ... }:

with lib;

let
  kevin-cfg = config.kevin;

  vpnSubmodule = with lib.types; submodule {
    options = {
      enable = mkEnableOption "VPN Client";
      ips    = mkOption { type = listOf str; };
      allowedIPs = mkOption { type = listOf str; };
    };
  };

  vpnHostSubmodule = with lib.types ; submodule {
    options = {
      enable         = mkEnableOption "VPN Host";
      v4Base         = mkOption { type = str; };
      prefix         = mkOption { type = str; };
      prefixLength   = mkOption { type = int; };
      port           = mkOption { type = int; };
      upstreamIfname = mkOption { type = str; };
      peers          = mkOption { type = attrs; };
    };
  };

  wireguard4Addr = v4Base: ordinal: "${v4Base}.${toString (0 + ordinal)}";

  sharedClientConfig = { name, interface, publicKey, endpoint, ips, allowedIPs }: {
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
        inherit publicKey endpoint allowedIPs;
        persistentKeepalive = 25;
      }];
    };
  };

  sharedHostConfig = { v4Base, prefix, prefixLength, port, upstreamIfname, peers} : {
      networking.wireguard.interfaces = {
        wg4 = {
          # TODO Make nat optional
          ips = [ (wireguard4Addr v4Base 1) "${prefix}::1/${toString prefixLength}" ];
          listenPort = port;
          privateKeyFile = "/etc/nixos/wireguard-private-key";

          peers = lib.mapAttrsToList (n: { ordinal, publicKey, ... }: {
            inherit publicKey;
            allowedIPs = [
              "${wireguard4Addr v4Base ordinal}/32"
              "${prefix}::${toString ordinal}/128"
            ];
          }) peers;

          postSetup = (lib.concatStrings (lib.mapAttrsToList (n: { ordinal, ...}: ''
            ${pkgs.iproute}/bin/ip -6 neigh add proxy ${prefix}::${toString ordinal} dev ${upstreamIfname}
      '') peers)) + ''
            ${pkgs.iproute}/bin/ip link set wg4 mtu ${toString (1420 - 20)}
          '';

          postShutdown = lib.concatStrings (lib.mapAttrsToList (n: { ordinal, ... }: ''
            ${pkgs.iproute}/bin/ip -6 neigh del proxy ${prefix}::${toString ordinal} dev ${upstreamIfname}
          '') peers);
        };
      };

      boot.kernel.sysctl = {
        "net.ipv4.conf.all.forwarding" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
        "net.ipv6.conf.all.proxy_ndp" = 1;
      };

      # TODO Optional ARP forwarding

      # TODO Make nat optional
      networking.nat.enable = true;
      networking.nat.externalInterface = upstreamIfname;
      networking.nat.internalIPs = [ "${v4Base}.0/24" ];

      networking.firewall.extraCommands = ''
        ip46tables -N wireguard-incoming

        ip46tables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

        ip46tables -A FORWARD -i wg4 -m conntrack --ctstate NEW -j wireguard-incoming

        ip46tables -A FORWARD -j nixos-fw-log-refuse

        ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: { ordinal, ... }: ''
          iptables -A wireguard-incoming \
            -s ${wireguard4Addr v4Base ordinal} \
            -m comment --comment "Full access from ${k}" \
            -j ACCEPT

          ip6tables -A wireguard-incoming \
            -s ${prefix}::${toString ordinal} \
            -m comment --comment "Full access from ${k}" \
            -j ACCEPT
        '') peers)}
      '';

      networking.firewall.extraStopCommands = ''
        ip46tables -F FORWARD
        ip46tables -F wireguard-incoming
        ip46tables -X wireguard-incoming
      '';

      networking.firewall.allowedUDPPorts = [ port ];
  };
in
{

  # Import Wireguard module with namespace support
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
      tomoyo-vpn = mkOption {
        type = vpnSubmodule;
        default = {};
      };
      vpn-host = mkOption {
        type = vpnHostSubmodule;
        default = {};
      };
    };
  };

  config = mkMerge [
    (mkIf kevin-cfg.iknow-vpn.enable (sharedClientConfig {
      name = "iknow";
      interface = "wg0";
      publicKey = "T3w2pRLJTKArHLxA4uGgG07XHv4JkGBCrilnXkpNGTs=";
      endpoint = "111.108.92.242:52336";
      inherit (kevin-cfg.iknow-vpn) ips allowedIPs;
    }))

    (mkIf kevin-cfg.tomoyo-vpn.enable (sharedClientConfig {
      name = "tomoyo";
      interface = "wg1";
      publicKey = "h+lBOnF+dvUEmNRfBQ22F5mZpYN27i6VBcjcNk6fdAE=";
      endpoint = "202.182.98.97:52337";
      inherit (kevin-cfg.tomoyo-vpn) ips allowedIPs;
    }))

    (mkIf kevin-cfg.vpn-host.enable (sharedHostConfig {
      inherit (kevin-cfg.vpn-host) v4Base prefix prefixLength port upstreamIfname peers;
    })
    )
  ];
}


