{ stdenv, fetchFromGitHub, fetchurl, cmake }:

let
  cmake_dep = if stdenv.lib.versionOlder cmake.version "3.15" then
    cmake.overrideAttrs (o: rec {
      name = "${pname}-${version}";
      pname = "cmake";
      version = "3.15.4";

      src = fetchurl {
        url = "${o.meta.homepage}files/v${"3.15"/* majorVersion */}/cmake-${version}.tar.gz";
        # from https://cmake.org/files/v3.15/cmake-3.15.4-SHA-256.txt
        sha256 = "8a211589ea21374e49b25fc1fc170e2d5c7462b795f1b29c84dd0e984301ed7a";
      };
    })
    else cmake;
in
stdenv.mkDerivation rec {
  pname = "zps";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "orhun";
    repo = pname;
    rev = "refs/tags/${version}";
    sha256 = "1433sj589br904j00p8awb0qh8m4qr8hh1im4y98z259whcf1g4z";
  };

  nativeBuildInputs = [ cmake_dep ];

  meta = with stdenv.lib; {
    description = "Small utility for listing and reaping zombie processes";
    homepage = "https://github.com/orhun/zps";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ dtzWill ];
  };
}
