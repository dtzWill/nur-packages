{ callPackage, pkgs }:


rec {
  diva = callPackage ./pkgs/diva { };

  fcd4 = callPackage ./pkgs/fcd/4.nix { };
  fcd4-tests = callPackage ./pkgs/fcd/test.nix { fcd = fcd4; };

  kittel-koat = callPackage ./pkgs/kittel-koat {
    ocamlPackages = pkgs.ocaml-ng.ocamlPackages_4_03;
  };
  #libbeauty = callPackage ./pkgs/libbeauty {
  #  inherit (pkgs.llvmPackages_4) stdenv llvm;
  #};
  llvm2kittel = callPackage ./pkgs/llvm2kittel {
    inherit (pkgs.llvmPackages_4) llvm;
  };

  publib = callPackage ./pkgs/publib { };
  slinky = callPackage ./pkgs/slinky { inherit publib; };
  slinky32 = pkgs.pkgsi686Linux.callPackage ./pkgs/slinky { inherit publib; };

  slipstream-ipcd = callPackage ./pkgs/slipstream/ipcd.nix { };
  slipstream-libipc = callPackage ./pkgs/slipstream/libipc.nix { inherit slipstream-ipcd; };
}
