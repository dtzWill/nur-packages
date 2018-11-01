{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-10-31";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "1f612e26ed56d9f41fcfc18a94b905502dff6fe6";
      sha256 = "0gi85fji52snwzcqncx7v3sa0wjg12rj68law55qj8g9h8c4g4ph";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
