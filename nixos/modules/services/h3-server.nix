{ config, secretsPath, ... }:
let
  dev-user = "h3-backend-dev";
  dev-group = "h3-backend-dev";
in
{
  age.secrets.h3_dev-jwt-secret = {
    file = "${secretsPath}/h3/dev-jwt-secret.age";
    mode = "400";
    owner = dev-user;
    group = dev-group;
  };

  age.secrets.h3_dev-azure-service-bus = {
    file = "${secretsPath}/h3/dev-azure-service-bus.age";
    mode = "400";
    owner = dev-user;
    group = dev-group;
  };

  services.postgresql = {
    ensureDatabases = [ dev-user ];
    ensureUsers = [
      {
        name = dev-user;
        ensureDBOwnership = true;
      }
    ];
  };

  services.h3-server.dev = {
    enable = true;
    backendAuthority = "api.hub.nhdhopehouseguthrie.org";
    frontendOrigin = "https://hub.nhdhopehouseguthrie.org";
    jwtSecretFile = config.age.secrets.h3_dev-jwt-secret.path;
    azureServiceBusFile = config.age.secrets.h3_dev-azure-service-bus.path;
    user = dev-user;
    group = dev-group;
    database = {
      host = "/run/postgresql";
      name = dev-user;
      user = dev-user;
      port = 5432;
    };
  };
}
