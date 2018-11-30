{ stdenv, bison, flex, fetchurl }:

stdenv.mkDerivation rec {
  name = "txr-${version}";
  version = "203";

  src = fetchurl {
    url = "http://www.kylheku.com/cgit/txr/snapshot/${name}.tar.bz2";
    sha256 = "1lhcgr8h39bjn0bdcl10n7d1q5hygspza8m2xmcmgqjp8542mlx8";
  };

  nativeBuildInputs = [ bison flex ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Programming language for convenient data munging";
    license = licenses.bsd2;
    homepage = http://nongnu.org/txr;
    maintainers = with stdenv.lib.maintainers; [ dtzWill ];
  };
}
