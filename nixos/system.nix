{
  adminPublicKeys,
  inputs,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit
      adminPublicKeys
      inputs
      ;
  };

  modules = [
    inputs.agenix.nixosModules.default
    ./configuration.nix
  ];
}
