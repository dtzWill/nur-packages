{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-08-03";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "ee23492712f8ca1de1d879f873e9a5ad61f5fdff";
      sha256 = "063q25ygz46fin2vbki4vwg5g3p8az3j3miidfrdyr3qq2i9qpfv";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
