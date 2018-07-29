{ stdenv, fetchFromGitHub, mbuild }:

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

  installPhase = ''
    python ./mfile.py install --shared --install-dir=$out
    ln -s $out/include/xed/* $out/include
    rm -r $out/{mbuild,misc,LICENSE,examples,README.md,bin}
  '';

  meta = with stdenv.lib; {
    description = "x86 encoder decoder";
    homepage = https://github.com/intelxed/xed;
    license = licenses.asl20;
  };
}
