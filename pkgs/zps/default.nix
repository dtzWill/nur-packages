{ stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "zps";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "orhun";
    repo = pname;
    rev = "refs/tags/${version}";
    sha256 = "1433sj589br904j00p8awb0qh8m4qr8hh1im4y98z259whcf1g4z";
  };

  nativeBuildInputs = [ cmake ];

  meta = with stdenv.lib; {
    description = "Small utility for listing and reaping zombie processes";
    homepage = "https://github.com/orhun/zps";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ dtzWill ];
  };
}
