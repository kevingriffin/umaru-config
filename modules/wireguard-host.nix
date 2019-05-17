{ config, lib, pkgs, ... }:

let
  # This is my machine's v6 prefix?
  wireguardPrefix = "2001:19f0:7001:4b5d";
  wireguard4Addr = ordinal: "192.168.2.${toString (0 + ordinal)}";
  wireguardPort = 52337;

  upstreamIfname = "ens3";

  peers = {
    "chieri" = { ordinal = 2; publicKey = "Oo9fzy6JAuvG9S1qR2ACVbUjKxPLQFsHqg4uDGQQHTY="; };
    "alpha"  = { ordinal = 3; publicKey = "erWAQdCkqatIRy1+01mhBWPg8KApwVrzNxuRGeMGvwE="; };
    "umaru"  = { ordinal = 4; publicKey = "h/trC+5Z8qbGBJtroYITQGMNUn5XQZ/JRqVR3iIH5Ro="; };
    "erika"  = { ordinal = 5; publicKey = "PBy+Msv2RZSSH9UodBa1JJ5ZsuER7rXinuW2QkzemAE="; };
  };

  fullAccessPeers = lib.filterAttrs (k: v: v.fullAccess or true) peers;
in
{
  networking.wireguard.interfaces = {
    wg4 = {
      ips = [ (wireguard4Addr 1) ];
      listenPort = wireguardPort;
      privateKeyFile = "/etc/nixos/wireguard-private-key";

      peers = lib.mapAttrsToList (n: { ordinal, publicKey, ... }: {
        inherit publicKey;
        allowedIPs = [
          "${wireguard4Addr ordinal}/32"
          "${wireguardPrefix}::${toString ordinal}/128"
        ];
      }) peers;

      postSetup = ''
        ${pkgs.iproute}/bin/ip link set wg4 mtu ${toString (1420 - 20)}
      '';
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking.nat.enable = true;
  networking.nat.externalInterface = upstreamIfname;
  networking.nat.internalIPs = [ "192.168.2.0/24" ];

  networking.firewall.extraCommands = ''
    ip46tables -N wireguard-incoming

    ip46tables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

    ip46tables -A FORWARD -i wg4 -m conntrack --ctstate NEW -j wireguard-incoming

    ip46tables -A FORWARD -j nixos-fw-log-refuse

    ${lib.concatStringsSep "\n" (lib.mapAttrsToList (k: { ordinal, ... }: ''
      iptables -A wireguard-incoming \
        -s ${wireguard4Addr ordinal} \
        -m comment --comment "Full access from ${k}" \
        -j ACCEPT

      ip6tables -A wireguard-incoming \
        -s ${wireguardPrefix}::${toString ordinal} \
        -m comment --comment "Full access from ${k}" \
        -j ACCEPT
    '') fullAccessPeers)}
  '';

  networking.firewall.extraStopCommands = ''
    ip46tables -F FORWARD
    ip46tables -F wireguard-incoming
    ip46tables -X wireguard-incoming
  '';

  networking.firewall.allowedUDPPorts = [ wireguardPort ];
}
