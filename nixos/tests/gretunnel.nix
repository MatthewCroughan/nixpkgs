{ pkgs, ... }:
{
  name = "gre";
  meta = with pkgs.lib.maintainers; {
    maintainers = [ matthewcroughan ];
  };

  nodes = {
    host-a =
      { config, pkgs, ... }:
      {
        networking.firewall.enable = false;
        networking.useNetworkd = true;
        boot.kernel.sysctl = {
          # Enable IPv4 forwarding
          "net.ipv4.conf.all.forwarding" = true;
          # Enable IPv6 forwarding
          "net.ipv6.conf.all.forwarding" = 1;
        };
        systemd.network = {
          enable = true;
          netdevs."40-gretap6" = {
            netdevConfig = {
              Name = "ip6gretap0";
              Kind = "ip6gretap";
            };
            tunnelConfig = {
              Local = "2001:db8:1::1";
              Remote = "2001:db8:1::2";
            };
          };
          networks."40-eth1" = {
            tunnel = [ "ip6gretap0" ];
          };
          networks."40-gretap6" = {
            address = [ "10.100.0.1/30" ];
            matchConfig.Name = "ip6gretap0";
            linkConfig = {
              MTUBytes = "1476";
            };
          };
        };
        environment.systemPackages = [ pkgs.unixtools.arp ];
      };
    host-b  =
      { config, pkgs, ... }:
      {
        networking.firewall.enable = false;
        networking.useNetworkd = true;
        boot.kernel.sysctl = {
          # Enable IPv4 forwarding
          "net.ipv4.conf.all.forwarding" = true;
          # Enable IPv6 forwarding
          "net.ipv6.conf.all.forwarding" = 1;
        };
        systemd.network = {
          enable = true;
          netdevs."40-gretap6" = {
            netdevConfig = {
              Name = "ip6gretap0";
              Kind = "ip6gretap";
            };
            tunnelConfig = {
              Local = "2001:db8:1::2";
              Remote = "2001:db8:1::1";
            };
          };
          networks."40-eth1" = {
            tunnel = [ "ip6gretap0" ];
          };
          networks."40-gretap6" = {
            tunnel = [ "ip6gretap0" ];
            address = [ "10.100.0.2/30" ];
            matchConfig.Name = "ip6gretap0";
            linkConfig = {
              MTUBytes = "1476";
            };
          };
        };
        environment.systemPackages = [ pkgs.unixtools.arp ];
      };
  };

  testScript = ''
    start_all()
  '';
}


