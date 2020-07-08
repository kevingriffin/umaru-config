{ config, lib, pkgs, ... }:
let
  ipv4Address    = "192.168.11.1";
  intIpv6Address = "2404:7a80:32e1:6600:85:c832:e100:6600";
  hosts = import ../hosts.nix;
in
{
  services.dnsmasq = {
    enable = true;

    resolveLocalQueries = true;

    servers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];

    extraConfig = ''
      bind-interfaces
      listen-address=${intIpv6Address},${ipv4Address},127.0.0.1,::1
      conf-file=${pkgs.dnsmasq}/share/dnsmasq/trust-anchors.conf
      dnssec

      domain=kevin.jp
      dhcp-range=192.168.11.50,192.168.11.100,255.255.255.0,192.168.11.255,12h
      dhcp-range=::,static

      dhcp-host=00:0C:29:C5:77:FC,192.168.11.33 # flonne
      dhcp-host=9C:5C:8E:BC:05:C0,192.168.11.3 # erika
      dhcp-host=F0:18:98:E7:FB:D3,192.168.11.9 # haru
      dhcp-host=9C:5C:8E:BC:C9:10,192.168.11.80 # umaru
      dhcp-host=90:48:9A:85:70:1A,192.168.11.94 # tvb928217d081b
      dhcp-host=00:0E:C6:E5:58:F4,192.168.11.98
      dhcp-host=00:22:CF:F6:C4:C9,192.168.11.96


      dhcp-option=option:router,${ipv4Address}
      dhcp-option=option:ntp-server,${ipv4Address}
      dhcp-option=option6:ntp-server,${intIpv6Address}
      dhcp-option=option6:dns-server,${intIpv6Address}
      dhcp-option=option6:domain-search,kevin.jp

      dhcp-authoritative

      cache-size=10000
      quiet-dhcp
    '';
  };

  services.prometheus.exporters.dnsmasq = {
    enable = true;
    leasesPath = "/var/lib/dnsmasq/dnsmasq.leases";
  };
}
