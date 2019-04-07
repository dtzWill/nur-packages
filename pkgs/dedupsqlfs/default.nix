{ python3, lib, fetchFromGitHub, pkgs }:

python3.pkgs.buildPythonApplication rec {
  pname = "dedupsqlfs";
  version = "1.2.938pre";

  src = fetchFromGitHub {
    owner = "sergey-dryabzhinsky";
    repo = pname;
    rev = "a1b04f3e36af9955e6cf68e48326066171d2efeb";
    sha256 = "034gsr3xrg09slc6p1p1jdsn6mjmyfs4l5lff0385iq6cjih74ib";
  };

  doCheck = false; # revisit

  propagatedBuildInputs = 
    (with pkgs; [ brotli lzo snappy lz4 xz fuse3 sqlite mysql ])
    ++
    (with python3.pkgs; [ pymysql llfuse cython ]);


  patches = [ ./install.patch ];
}
