let
  adminPublicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKeb7OYEVYWXIuvyKrUeARMV1Eu7siUgmaIS89Rt9swd secrets@HopeHouseServer.git"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIo0rqolIwrG9+2xM6nQSDmPkEAprLEstESby+KtwoDa super@super-systems"
  ];
in
{
  # note: comment this before running `agenix -r`
  inherit adminPublicKeys;
}
