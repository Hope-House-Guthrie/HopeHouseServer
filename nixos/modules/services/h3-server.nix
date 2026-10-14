{ config, secretsPath, ... }:
let
  develop-db-user = "h3-develop";
  main-db-user = "h3-main";
in
{
  age.secrets.h3_develop-jwt-secret = {
    file = "${secretsPath}/h3/develop/jwt-secret.age";
    mode = "400";
    owner = config.services.h3-server.develop.user;
    group = config.services.h3-server.develop.group;
  };

  age.secrets.h3_develop-azure-service-bus = {
    file = "${secretsPath}/h3/develop/azure-service-bus.age";
    mode = "400";
    owner = config.services.h3-server.develop.user;
    group = config.services.h3-server.develop.group;
  };

  age.secrets.h3_main-jwt-secret = {
    file = "${secretsPath}/h3/main/jwt-secret.age";
    mode = "400";
    owner = config.services.h3-server.main.user;
    group = config.services.h3-server.main.group;
  };

  age.secrets.h3_main-azure-service-bus = {
    file = "${secretsPath}/h3/main/azure-service-bus.age";
    mode = "400";
    owner = config.services.h3-server.main.user;
    group = config.services.h3-server.main.group;
  };

  services.postgresql = {
    ensureDatabases = [ 
      develop-db-user 
      main-db-user 
    ];
    ensureUsers = [
      {
        name = develop-db-user;
        ensureDBOwnership = true;
      }
      {
        name = main-db-user;
        ensureDBOwnership = true;
      }
    ];
  };

  services.h3-server.develop = {
    enable = true;
    backendAuthority = "api.hub.nhdhopehouseguthrie.org";
    frontendOrigin = "https://hub.nhdhopehouseguthrie.org";
    jwtSecretFile = config.age.secrets.h3_develop-jwt-secret.path;
    azureServiceBusFile = config.age.secrets.h3_develop-azure-service-bus.path;
    database = {
      host = "/run/postgresql";
      name = develop-db-user;
      user = develop-db-user;
      port = 5432;
    };
  };

  services.h3-server.main = {
    enable = true;
    backendAuthority = "api.hub.hopehouseguthrie.org";
    frontendOrigin = "https://hub.hopehouseguthrie.org";
    jwtSecretFile = config.age.secrets.h3_main-jwt-secret.path;
    azureServiceBusFile = config.age.secrets.h3_main-azure-service-bus.path;
    database = {
      host = "/run/postgresql";
      name = main-db-user;
      user = main-db-user;
      port = 5432;
    };
  };
}
