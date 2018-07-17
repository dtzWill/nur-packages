{ stdenv, fetchFromGitHub, python, mbuild }:

stdenv.mkDerivation rec {
  name = "intelxed-${version}";
  version = "2018-04-13";
  src = fetchFromGitHub {
    owner = "intelxed";
    repo = "xed";
    rev = "2be2d282939f6eb84e03e1fed9ba82f32c8bac2d";
    sha256 = "1a9bc6hgcf0gm794cgkfkvi0n1hkww3fxm4apcvvl168fwm124n9";
  };

  postUnpack = ''
    t="$(ls -d xed-*)/mbuild"
    cp -ar ${mbuild} $t
    chmod u+w -R $t
  '';

  nativeBuildInputs = [ python ];

  buildPhase = ''
    python ./mfile.py -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    python ./mfile.py -j$NIX_BUILD_CORES --prefix=$out install
  '';

  meta = with stdenv.lib; {
    description = "x86 encoder decoder";
    license = licenses.asl20;
  };
}
