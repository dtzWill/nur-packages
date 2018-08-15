{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-08-10";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "0ef8ed3921e47f04b634f61371768bfeb1fcf423";
      sha256 = "0lz01nvaxggplaczsbp5p39gvasgnfigikw5jxhg53xs9y07lrk1";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
