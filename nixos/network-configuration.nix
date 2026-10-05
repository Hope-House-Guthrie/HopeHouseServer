{ constants, ... }:
{
  networking = {
    useNetworkd = true;
    useDHCP = false;
    nameservers = constants.network.dns;
  };

  systemd.network.networks = {
    "10-wan" = {
      matchConfig.Name = constants.network.wan.interface;
      address = [ "${constants.network.wan.address}/${constants.network.wan.cidr}" ];
      routes = [
        {
          Gateway = constants.network.wan.gateway;
          GatewayOnLink = true;
        }
        {
          Gateway = constants.network.wan.gateway;
          Table = 100;
        }
      ];
      routingPolicyRules = [
        {
          From = constants.network.wan.address;
          Table = 100;
          Priority = 1000;
        }
      ];
      dns = constants.network.dns;
    };

    "20-lan" = {
      matchConfig.Name = constants.network.lan.interface;
      address = [ "${constants.network.lan.address}/${constants.network.lan.cidr}" ];
      routes = [
        {
          Destination = constants.network.lan.subnet;
          Gateway = constants.network.lan.gateway;
          Table = 200;
        }
      ];
      routingPolicyRules = [
        {
          To = constants.network.lan.subnet;
          Table = 200;
          Priority = 500;
        }
        {
          From = constants.network.lan.address;
          Table = 200;
          Priority = 501;
        }
      ];
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.rp_filter" = 2;
    "net.ipv4.conf.default.rp_filter" = 2;
    "net.ipv4.conf.eno1.rp_filter" = 2;
    "net.ipv4.conf.eth1.rp_filter" = 2;
  };
}
