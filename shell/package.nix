{
  inputs,
  pkgs,
  stdenv,
  ...
}:
let
  system = stdenv.hostPlatform.system;
  agenix = inputs.agenix.packages.${system}.agenix;

  update-host = pkgs.writeShellScriptBin "update-host" ''
    set -e
    ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch \
      --flake .#hope-house-server \
      --sudo \
      --target-host admin@$192.168.0.128
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    age
    agenix
    nixd
    nixfmt
    starship
    update-host
    wireguard-tools
  ];

  shellHook = ''
    eval "$(starship init bash)"
  '';
}
