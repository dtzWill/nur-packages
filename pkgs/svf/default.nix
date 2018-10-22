{ pkgs, lib, callPackage }:

let
  svfs = {
    "4" = {
      path = ./4.nix;
      llvmPackages = pkgs.llvmPackages_4;
    };
    "6" = {
      path = ./6.nix;
      llvmPackages = pkgs.llvmPackages_6;
    };
    "master" = {
      path = ./master.nix;
      # likely llvm7 soon
      llvmPackages = pkgs.llvmPackages_6;
    };
  };
  mkPkgs = info: lib.recurseIntoAttrs rec {
    svf = callPackage info.path { inherit (info.llvmPackages) llvm; };
    ptaben-fi = callPackage ./ptaben.nix {
      inherit (info.llvmPackages) stdenv llvm clang;
      inherit svf;
    };
    ptaben-fs = ptaben-fi.override { testFSPTA = true; };
  };

in
  lib.mapAttrs' (n: v: lib.nameValuePair "svfPkgs_${n}" (mkPkgs v)) svfs
