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
}
