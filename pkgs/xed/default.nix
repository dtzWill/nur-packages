{ stdenv, fetchFromGitHub, mbuild, enableShared ? true }:

stdenv.mkDerivation rec {
  name = "intelxed-${version}";
  version = "2018-07-02";
  src = fetchFromGitHub {
    owner = "intelxed";
    repo = "xed";
    rev = "00c6aac256c994688e54ea5c758e97ba34cd8ebe";
    sha256 = "1757anm01nl0b7nqyh2bvgdrz5fhgvdyjpcx2nvg05v8icdj2xmh";
  };

  nativeBuildInputs = [ mbuild ];

  buildFlags = [
    "install"
    "-v1"
  ]
    ++ stdenv.lib.optional stdenv.cc.isClang "--compiler=clang"
    ++ stdenv.lib.optional enableShared "--shared";

  installPhase = ''
    python ./mfile.py $buildFlags --prefix $out
  '';

  meta = with stdenv.lib; {
    description = "x86 encoder decoder";
    homepage = https://github.com/intelxed/xed;
    license = licenses.asl20;
  };
}
