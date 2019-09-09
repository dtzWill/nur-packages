{ stdenv, fetchFromGitHub, cmake, pkgconfig, makeWrapper, elfutils, boost, tbb }:

stdenv.mkDerivation rec {
  pname = "dyninst";
  version = "10.1.0";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "refs/tags/v${version}";
    sha256 = "02263f59wpvgwkjrhrvrkjz4rdv3p6yj9j7ja5l5az2j153vaqzd";
  };

  nativeBuildInputs = [ cmake pkgconfig makeWrapper ];
  buildInputs = [ elfutils boost tbb ];

  postPatch = ''
    patchShebangs ./scripts
  '';

  postInstall = ''
    for x in $out/bin/*; do
      wrapProgram $out/bin --set DYNINSTAPI_RT_LIB ${placeholder "out"}/lib/libdyninstAPI_RT.so
    done
  '';

  meta = with stdenv.lib; {
    description = "Tools for binary instrumentation, analysis, and modification";
    license = licenses.lgpl21Plus;
    homepage = "https://dyninst.org/dyninst";
    maintainers = with maintainers; [ dtzWill ];
  };
}
