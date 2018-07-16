{ stdenv, lit, llvm, fetchgit }:

with import ./src.nix;
stdenv.mkDerivation {
  name = "llvmslicer-${version}";
  src = fetchgit srcinfo;
  inherit version;
  doCheck = true;
  enableParallelBuilding = true;

  # Patch around attempt to use bits from LLVM's source tree,
  # instead use the ones shipped with this project already :)
  patchPhase = ''
    sed -i -e 's,{llvm_src}/autoconf/,{srcdir}/autoconf/,g' configure
  '';

  # This is needed when the host compiler doesn't default to C++11.
  configureFlags = "--enable-cxx11";

  buildInputs = [ lit llvm ];

  meta = with stdenv.lib; {
    description = "Slicer for LLVM 3.5";
    license = licenses.ncsa;
    homepage = https://github.com/sdasgup3/llvm-slicer;
  };
}
