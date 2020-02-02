{ nixpkgs ? (fetchTarball channel:nixos-unstable),
  src ? (fetchGit ../.)
}:

# Evaluate 'release.nix' but don't abort on unfree, just log and skip

let
  toplevel = import (src + "/release.nix") {
    inherit nixpkgs;
    args.config = {
      allowUnfree = false;
    };
  };
in
  toplevel // {
    pkgs = builtins.removeAttrs toplevel.pkgs [
      # unfree
      "diva"
      "stoke" "stoke-haswell" "stoke-sandybridge"
      "ycomp"
      
      # Need LLVM versions removed in latest nixpkgs :(
      "fcd4" "fcd4-tests"
      "llvm-dbas"
      "llvmslicer"
      "remill"
      "vmir-clang4"
      "svfPkgs_4"
      "dg_4"
    ];
  }
