{
  imports = [
    ./hardware-configuration.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  networking.hostName = "hope-house-server";
  system.stateVersion = "26.05";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
