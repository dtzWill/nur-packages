{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-07-03";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "b7ddf981ae1e3be79eab691f6cf844313ee66b77";
      sha256 = "0f47579hlbdb1mivxc2l91xvf0577v8n4x4vmgr76nn2nqq7s75q";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
