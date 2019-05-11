{ lib, ... }:

{
  nix.nixPath = lib.mkBefore [
    "nixos-dtz=https://github.com/dtzWill/nixpkgs/archive/nixos-dtz.tar.gz"
  ];
}
