{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-05-16";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "f6d9758675e6bb31e61e13c33503ab90242fcb25";
      sha256 = "04228sypjja31f1bjfg3m3q9d1msx8rl3p9r51aik1jgyx7c3y4f";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } { }
