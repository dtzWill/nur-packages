{ stdenv, fetchFromGitHub, xorg, boost, cmake }:

stdenv.mkDerivation rec {
  name = "xlayout-${version}";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "alex-courtis";
    repo = "xlayoutdisplay";
    rev = "v${version}";
    sha256 = "1cqn98lpx9rkfhavbqalaaljw351hvqsrszgqnwvcyq05vq26dwx";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = with xorg; [ libX11 libXrandr libXcursor boost ];

  meta = with stdenv.lib; {
    license = licenses.asl20;
  };
}
