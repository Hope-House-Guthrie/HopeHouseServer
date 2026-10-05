{
  network = {
    wan = {
      interface = "eno1";
      address = "57.138.30.25";
      gateway = "57.138.30.1";
      cidr = "24";
    };
    lan = {
      interface = "eth1";
      address = "192.168.0.128";
      gateway = "192.168.0.1";
      cidr = "24";
      subnet = "192.168.0.0/16";
    };
    dns = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}
