{ stdenv, fetchFromGitHub, llvm, cmake }:

let
  srcinfo = {
    version = "2018-07-22";
    src = fetchFromGitHub {
      owner = "SVF-tools";
      repo = "SVF";
      rev = "31c86b143fc6796bb7f9c51645217f1c09d7e8a5";
      sha256 = "1lcb42szp28bp08v016k38gl64l31vqahcdy664sb980vbg8j8b5";
    };
  };
in import ./generic.nix { inherit stdenv llvm cmake srcinfo; } {
  postInstall = ''
    install -Dm755 {.,$out}/bin/saber
    install -Dm755 {.,$out}/bin/wpa
  '';
}
