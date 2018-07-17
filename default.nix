{ callPackage, pkgs }:


rec {
  alive = callPackage ./pkgs/alive { };

  diva = callPackage ./pkgs/diva { };

  dwarf-type-reader = callPackage ./pkgs/dwarf-type-reader {
    inherit (pkgs.llvmPackages_5) llvm;
  };

  fcd4 = callPackage ./pkgs/fcd/4.nix { };
  fcd4-tests = callPackage ./pkgs/fcd/test.nix { fcd = fcd4; };

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
