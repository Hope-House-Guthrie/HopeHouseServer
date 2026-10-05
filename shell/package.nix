{
  constants,
  inputs,
  pkgs,
  stdenv,
  ...
}:
let
  system = stdenv.hostPlatform.system;
  agenix = inputs.agenix.packages.${system}.agenix;
  nixosConfiguration = "h2-server";

  update-host = pkgs.writeShellScriptBin "update-host" ''
    set -e
    ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch \
      --flake .#${nixosConfiguration} \
      --sudo \
      --target-host admin@${constants.network.lan.address}
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    age
    agenix
    nixd
    nixfmt
    openssl
    starship
    update-host
  ];

  shellHook = ''
    eval "$(starship init bash)"
  '';
}
