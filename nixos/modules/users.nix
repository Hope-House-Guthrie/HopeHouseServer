{
  lib,
  adminPublicKeys,
  config,
  self,
  ...
}:
{
  age.secrets.root_passwd = {
    file = "${self}/secrets/root_passwd.age";
    mode = "0400";
  };

  users = {
    mutableUsers = false;

    users.root.hashedPasswordFile = config.age.secrets.root_passwd.path;

    users.admin = {
      isNormalUser = true;
      hashedPassword = "!";
      openssh.authorizedKeys.keys = adminPublicKeys;
      extraGroups = [
        "wheel"
      ];
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  nix.settings.trusted-users = [
    "root"
    "admin"
  ];
}
