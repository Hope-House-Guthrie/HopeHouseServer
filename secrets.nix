let
  adminPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKeb7OYEVYWXIuvyKrUeARMV1Eu7siUgmaIS89Rt9swd secrets@HopeHouseServer.git"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIo0rqolIwrG9+2xM6nQSDmPkEAprLEstESby+KtwoDa super@super-systems"
  ];

  hostPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEoLAi0CkNQx3WY9fgA0oaG+8RMVym92ymolQpO5FMNr root@hope-house-server";
in
{
  # note: comment this before running `agenix -r`
  inherit adminPublicKeys;

  "secrets/root_passwd.age".publicKeys = adminPublicKeys ++ [ hostPublicKey ];
}
