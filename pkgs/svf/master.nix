{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-11-02";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "ff78094e65f2577e8b1f303a902dd7e10a4e1705";
      sha256 = "0wr8hmrzy1f115k9f7dd91slv4h9ahkqgi5hyp1i5zfq81s2a8am";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
