{ stdenv, fetchFromGitHub, python, mbuild }:

stdenv.mkDerivation rec {
  name = "intelxed-${version}";
  version = "2018-07-02";
  src = fetchFromGitHub {
    owner = "intelxed";
    repo = "xed";
    rev = "00c6aac256c994688e54ea5c758e97ba34cd8ebe";
    sha256 = "1757anm01nl0b7nqyh2bvgdrz5fhgvdyjpcx2nvg05v8icdj2xmh";
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
