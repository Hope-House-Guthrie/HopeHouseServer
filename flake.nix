{
  description = "Hope House Server";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

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

      shell = pkgs.callPackage ./shell/package.nix {
        inherit inputs;
      };
    in
    {
      devShells.${system}.default = shell;
    };
}
