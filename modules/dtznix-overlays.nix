{ ... }:

let
  lib = import ../lib.nix;
in {
  nixpkgs.overlays = builtins.attrValues (lib.importDirectory ../overlays.nix);
}
