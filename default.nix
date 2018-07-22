{ pkgs ? import <nixpkgs> {} }:

pkgs.lib.makeScope pkgs.newScope (self: with self; {
  lib = pkgs.lib // import ./lib;
  alive = callPackage ./pkgs/alive { };

  # XXX: madness?
  allvm-tools = callPackage ./pkgs/allvm/tools-from-nar.nix { };

  ccontrol = callPackage ./pkgs/ccontrol { };

  dg_6 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_6) stdenv llvm;
  };
  dg_5 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_5) stdenv llvm;
  };
  dg_4 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_4) stdenv llvm;
  };
  /*
  dg_39 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_39) stdenv clang llvm;
  };
  dg_38 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_38) stdenv clang llvm;
  };
  dg_37 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_37) stdenv clang llvm;
  };
  dg_35 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_35) llvm;
    clang = pkgs.clang_35;
  };
  */
  dg = dg_4;

  diva = callPackage ./pkgs/diva { };

  dwarf-type-reader = callPackage ./pkgs/dwarf-type-reader {
    inherit (pkgs.llvmPackages_5) llvm;
  };

  fcd4 = callPackage ./pkgs/fcd/4.nix { };
  fcd4-tests = callPackage ./pkgs/fcd/test.nix { fcd = fcd4; };

  intelxed = callPackage ./pkgs/xed/default.nix { };
  mbuild = callPackage ./pkgs/xed/mbuild.nix { };

  kittel-koat = callPackage ./pkgs/kittel-koat {
    ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_03;
  };
  #libbeauty = callPackage ./pkgs/libbeauty {
  #  inherit (pkgs.llvmPackages_4) stdenv llvm;
  #};
  libebc = callPackage ./pkgs/libebc {
    inherit (pkgs.llvmPackages_4) llvm;
  };
  llvm2kittel = callPackage ./pkgs/llvm2kittel {
    inherit (pkgs.llvmPackages_4) llvm;
  };
  llvmslicer = callPackage ./pkgs/llvmslicer {
    inherit (pkgs.llvmPackages_35) llvm;
  };

  nix-mux = callPackage ./pkgs/nix-mux { };

  publib = callPackage ./pkgs/publib { };
  slinky = callPackage ./pkgs/slinky { };
  # slinky32 = pkgs.pkgsi686Linux.callPackage ./pkgs/slinky { };

  slipstream-ipcd = callPackage ./pkgs/slipstream/ipcd.nix { };
  slipstream-libipc = callPackage ./pkgs/slipstream/libipc.nix { };

  svf_4 = callPackage ./pkgs/svf/4.nix { llvm = pkgs.llvm_4; };
  svf_6 = callPackage ./pkgs/svf { llvm = pkgs.llvm_6; };
  svf = svf_4;
  ptaben-fi_4 = callPackage ./pkgs/svf/ptaben.nix {
    inherit (pkgs.llvmPackages_4) llvm clang;
    svf = svf_4;
  };
  ptaben-fs_4 = ptaben-fi_4.override { testFSPTA = true; };
  ptaben-fi_6 = callPackage ./pkgs/svf/ptaben.nix {
    inherit (pkgs.llvmPackages_6) llvm clang;
    svf = svf_6;
  };
  ptaben-fs_6 = ptaben-fi_6.override { testFSPTA = true; };

})
