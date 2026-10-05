{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    authentication = ''
      # type  database        user            address                 auth-method
      local   all             all                                     trust
    '';
  };
}
