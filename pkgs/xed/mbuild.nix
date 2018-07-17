{ stdenv, fetchFromGitHub }:

let
  version = "2018-05-17";
  src = fetchFromGitHub {
    owner = "intelxed";
    repo = "mbuild";
    rev = "1651029643b2adf139a8d283db51b42c3c884513";
    sha256 = "1hdrzdyldszr4czfyw45niza4dyzbc2g14yskrz1c7fjhb6g4f6p";
  };
in
stdenv.mkDerivation {
  name = "intelxed-mbuild-${version}";
  inherit src version;

  installPhase = ''
    mkdir -p $out
    cp -ar * $out/
  '';
}
