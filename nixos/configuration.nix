{
  imports = [
    ./hardware-configuration.nix
    ./network-configuration.nix
    ./modules/nix.nix
    ./modules/ssh.nix
    ./modules/users.nix
    ./modules/services/caddy.nix
    ./modules/services/h3-server.nix
    ./modules/services/postgresql.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "h2-server";
  system.stateVersion = "26.05";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # todo: move probably

  virtualisation.vmVariant = {
    virtualisation.diskSize = 20480;
    virtualisation.memorySize = 4096;
  };
}
