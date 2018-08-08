{ stdenv, rustPlatform, llvm, clang, gcc, fetchgit, libffi }:

with import ./src.nix;
rustPlatform.buildRustPackage {
  name = "llstrata-${version}";
  inherit version;
  src = fetchgit srcinfo;

  buildInputs = [ llvm clang libffi ];

  cargoSha256 = "04xad7sa2bkhl1zbfa3i8wfhlpii0kk9zphmgjix0achc77jbha0";

  configurePhase = ''
    export LIBCLANG_PATH="${clang.cc}/lib"
    export CC=${gcc}/bin/cc
    export CXX=${gcc}/bin/c++
  '';

  preBuild = ''
    for c in $(find . -name Cargo.toml); do
      # Extract from 'name = "$NAME"'
      proj=$(sed -n 's/name = "\(.*\)"/\1/p' $c)
      echo "Running cargo build --release -p $proj"
      cargo build --release -p $proj
    done
  '';

  doCheck = true;

  checkPhase = ''
    for c in $(find . -name Cargo.toml); do
      # Extract from 'name = "$NAME"'
      proj=$(sed -n 's/name = "\(.*\)"/\1/p' $c)
      echo "Running cargo test -p $proj"
      cargo test -p $proj
    done
  '';
}
