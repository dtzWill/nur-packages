{ nixpkgs ? <nixpkgs> }:

let
  pkgs = import <nixpkgs> {};
in
  pkgs.callPackages ./default.nix {}
