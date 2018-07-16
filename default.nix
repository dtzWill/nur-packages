{ callPackage, pkgs }:


rec {
  diva = callPackage ./pkgs/diva { };

  publib = callPackage ./pkgs/publib { };
  slinky = callPackage ./pkgs/slinky { inherit publib; };
  slinky32 = pkgs.pkgsi686Linux.callPackage ./pkgs/slinky { inherit publib; };

  slipstream-ipcd = callPackage ./pkgs/slipstream/ipcd.nix { };
  slipstream-libipc = callPackage ./pkgs/slipstream/libipc.nix { inherit slipstream-ipcd; };
}
