{ callPackage, pkgs }:


rec {
  alive = callPackage ./pkgs/alive { };

  ccontrol = callPackage ./pkgs/ccontrol { };

  dg_6 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_6) stdenv clang llvm;
  };
  dg_5 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_5) stdenv clang llvm;
  };
  dg_4 = callPackage ./pkgs/dg {
    inherit (pkgs.llvmPackages_4) stdenv clang llvm;
  };
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
  dg = dg_4;

  diva = callPackage ./pkgs/diva { };

  dwarf-type-reader = callPackage ./pkgs/dwarf-type-reader {
    inherit (pkgs.llvmPackages_5) llvm;
  };

  fcd4 = callPackage ./pkgs/fcd/4.nix { };
  fcd4-tests = callPackage ./pkgs/fcd/test.nix { fcd = fcd4; };

  intelxed = callPackage ./pkgs/xed/default.nix { inherit mbuild; };
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

  publib = callPackage ./pkgs/publib { };
  slinky = callPackage ./pkgs/slinky { inherit publib; };
  slinky32 = pkgs.pkgsi686Linux.callPackage ./pkgs/slinky { inherit publib; };

  slipstream-ipcd = callPackage ./pkgs/slipstream/ipcd.nix { };
  slipstream-libipc = callPackage ./pkgs/slipstream/libipc.nix { inherit slipstream-ipcd; };
}
