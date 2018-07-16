{ stdenv, fetchFromGitHub,
# Native build inputs
cmake,
perl, groff, python,
# Build inputs
libxml2,
# libffi
ncurses, zlib,
}:

let
  release = "1.0";
in stdenv.mkDerivation rec {
  name = "capstone2llvmir-${version}";
  version = "${release}.0";

  src = fetchFromGitHub {
    owner = "avast-tl";
    repo = "capstone2llvmir";
    name = "capstone2llvmir-v${release}";
    rev = "refs/tags/v${release}";
    sha256 = "1mx36fhg8lgzc6w3r74krj0zrc6y0gyjlvybjc11idpr1i3sd92q";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake perl groff python ];

  buildInputs = [ libxml2 ncurses zlib ];

  prePatch = ''
    substituteInPlace deps/llvm/CMakeLists.txt --replace \
      "rt dl tinfo" "rt dl ncurses"
  '';

  cmakeFlags = [
    "-DCAPSTONE2LLVMIR_TOOLS=ON"
    # "-DCAPSTONE2LLVMIR_TESTS=ON"
  ];

  # doCheck = true;

  enableParallelBuilding = true;

}
