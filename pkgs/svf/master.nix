{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-11-01";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "de9dfe55be5bad9900759170d31868377e506e8f";
      sha256 = "0gsza1lv5rqvyp6jd0wi66rb27f4s996v9yr2048vkrlvpv1lhx0";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
