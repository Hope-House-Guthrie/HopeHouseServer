{
  adminPublicKeys,
  constants,
  inputs,
  secretsPath,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit
      adminPublicKeys
      constants
      inputs
      secretsPath
      ;
  };

  modules = [
    inputs.agenix.nixosModules.default
    (inputs.h3-develop.nixosModules.h3-server { hostingEnvironment = "develop"; })
    (inputs.h3-main.nixosModules.h3-server { hostingEnvironment = "main"; })
    ./configuration.nix
  ];
}
