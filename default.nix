{ callPackage, pkgs }:


let
  pkgs1709 = import (fetchTarball channel:nixos-17.09) { };
in rec {
  diva = callPackage ./pkgs/diva { };

  llvm-md-704 = pkgs1709.callPackage ./pkgs/llvm-md {
    ghc = pkgs1709.haskell.packages.ghc704.ghcWithPackages (p: [ p.mtl p.syb p.binary ]);
  };
  llvm-md-763 = pkgs1709.callPackage ./pkgs/llvm-md {
    ghc = pkgs1709.haskell.packages.ghc763.ghcWithPackages (p: [ p.mtl p.syb ]);
  };
  llvm-md = callPackage ./pkgs/llvm-md {
    ghc = pkgs.haskell.packages.ghc7103.ghcWithPackages (p: [ p.mtl p.syb ]);
    #ghc = pkgs.haskellPackages.ghcWithPackages (p: [ p.mtl p.syb p.binary ]);
  };

  publib = callPackage ./pkgs/publib { };
  slinky = callPackage ./pkgs/slinky { inherit publib; };
  slinky32 = pkgs.pkgsi686Linux.callPackage ./pkgs/slinky { inherit publib; };
}
