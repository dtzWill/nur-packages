{ stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "yarpgen";
  version = "unstable-2019-09-16";

  src = fetchFromGitHub {
    owner = "intel";
    repo = pname;
    rev = "771d6f608ee2d51c1757b6e485c096c7177e04c6";
    sha256 = "0mxnxrc21h1z8nq2g8331p3bdhkffwddrask3wqc0czb6fgsnnkr";
  };

  nativeBuildInputs = [ cmake ];

  # Install the main executable, at least
  installPhase = ''
    install -Dm755 -t $out/bin ${pname}
  '';
}
