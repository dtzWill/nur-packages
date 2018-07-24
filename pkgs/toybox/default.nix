{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "toybox-${version}";
  version = "0.7.7";

  src = fetchurl {
    url = "http://landley.net/toybox/downloads/${name}.tar.gz";
    sha256 = "187viyc1g2rin58gird615cw6qh069cpznia2424q1403jr8l8gf";
  };

  postPatch = "patchShebangs .";

  configurePhase = "make defconfig";

  installFlags = [ "PREFIX=$(out)" ];

  doCheck = true;
}
