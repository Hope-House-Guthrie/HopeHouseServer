{
  description = "Hope House Server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

    h3-develop = {
      url = "github:Hope-House-Guthrie/HopeHouseHub/develop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    h3-main = {
      url = "github:Hope-House-Guthrie/HopeHouseHub/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;
      };

      constants = import ./constants.nix;

      shell = pkgs.callPackage ./shell/package.nix {
        inherit constants inputs;
      };

      adminPublicKeys = (import ./secrets.nix).adminPublicKeys;

      secretsPath = ./secrets;
    in
    {
      devShells.${system}.default = shell;

      nixosConfigurations.h2-server = (import ./nixos/system.nix) {
        inherit
          adminPublicKeys
          constants
          inputs
          secretsPath
          ;
      };
    };
}
