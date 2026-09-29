{
  adminPublicKeys,
  inputs,
  self,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit
      adminPublicKeys
      inputs
      self
      ;
  };

  modules = [
    inputs.agenix.nixosModules.default
    ./configuration.nix
  ];
}
