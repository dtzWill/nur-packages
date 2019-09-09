{ stdenv, fetchFromGitHub, cmake, pkgconfig, elfutils, boost, tbb }:

stdenv.mkDerivation rec {
  pname = "dyninst";
  version = "10.1.0";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "refs/tags/v${version}";
    sha256 = "02263f59wpvgwkjrhrvrkjz4rdv3p6yj9j7ja5l5az2j153vaqzd";
  };

  nativeBuildInputs = [ cmake pkgconfig ];
  buildInputs = [ elfutils boost tbb ];

  postPatch = ''
    patchShebangs ./scripts
  '';

  meta = with stdenv.lib; {
    description = "Tools for binary instrumentation, analysis, and modification";
    license = licenses.lgpl21Plus;
    homepage = "https://dyninst.org/dyninst";
    maintainers = with maintainers; [ dtzWill ];
  };
}
