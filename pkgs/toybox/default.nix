{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "toybox-${version}";
  version = "0.7.6";

  src = fetchurl {
    url = "http://landley.net/toybox/downloads/${name}.tar.gz";
    sha256 = "15fvp5zv8pfjpcnhac5pywl0kgld885mvcldix6yrk9bphz69jg2";
  };

  postPatch = "patchShebangs .";

  preBuild = "make defconfig";

  installFlags = [ "PREFIX=$(out)" ];

  doCheck = true;
}
