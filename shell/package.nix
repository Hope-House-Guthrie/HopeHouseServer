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

  run-vm = pkgs.writeShellScriptBin "run-vm" ''
    set -e
    nix build .#nixosConfigurations.${nixosConfiguration}.config.system.build.vm \
      && result/bin/run-${nixosConfiguration}-vm
  '';
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    age
    agenix
    nixd
    nixfmt
    openssl
    run-vm
    starship
    update-host
  ];

  shellHook = ''
    eval "$(starship init bash)"
  '';
}
