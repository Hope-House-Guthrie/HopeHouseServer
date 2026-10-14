let
  adminPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKeb7OYEVYWXIuvyKrUeARMV1Eu7siUgmaIS89Rt9swd secrets@HopeHouseServer.git"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIo0rqolIwrG9+2xM6nQSDmPkEAprLEstESby+KtwoDa super@super-systems"
  ];

  hostPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEoLAi0CkNQx3WY9fgA0oaG+8RMVym92ymolQpO5FMNr root@h2-server";

  publicKeys = adminPublicKeys ++ [ hostPublicKey ];
in
{
  # note: comment this before running `agenix -r`
  inherit adminPublicKeys;

  "secrets/root-passwd.age" = { inherit publicKeys; };
  "secrets/wg-key.age" = { inherit publicKeys; };
  "secrets/h3/develop/jwt-secret.age" = { inherit publicKeys; };
  "secrets/h3/develop/azure-service-bus.age" = { inherit publicKeys; };
  "secrets/h3/main/jwt-secret.age" = { inherit publicKeys; };
  "secrets/h3/main/azure-service-bus.age" = { inherit publicKeys; };
}
