{
  inputs,
  pkgs,
  stdenv,
  ...
}:
let
  system = stdenv.hostPlatform.system;
  agenix = inputs.agenix.packages.${system}.agenix;
in 
pkgs.mkShell {
  buildInputs = with pkgs; [
    age
    agenix
    nixd
    nixfmt
    starship
    wireguard-tools
  ];

  shellHook = ''
    eval "$(starship init bash)"
  '';
}
