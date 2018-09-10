{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-09-10";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "ab806b876e1e6ec1e7fb32eb5052881aa62775d8";
      sha256 = "0is7b2da0z8wxlnim0s9xb63mbssmzk2zc4n240aby2xsmk6wblk";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
