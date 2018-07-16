{ stdenv, fetchurl, ghc, time }:

stdenv.mkDerivation rec {
  name = "llvm-md";
  src = fetchurl {
    url = "http://llvm-md.org/llvm-md.tgz";
    sha256 = "1m7a3z3b59769ll1z205m5k7lr83812i03fjq4sbkqzm2xdkii3k";
  };

  buildInputs = [ ghc time ];

  patches = (with stdenv.lib; optionals (versionOlder "7.4" ghc.version) [
    ./0001-Makefile-workaround-production-of-empty-file-on-erro.patch
    ./0002-attempt-to-work-around-Meta.hs-error.patch
    ./0003-Attempt-to-appease-errors-I-m-a-haskell-noob-so-don-.patch
    ./0004-fix-test-makefile.patch
  ]) ++ [
    ./0005-Makefile-Set-stack-size-RTS-during-build.patch
  ];


  unpackPhase = ''
    unpackFile $src
  '';

  # Don't run built-in test yet, needs clang 2.x and we don't build that (yet?)
  doCheck = false;

  checkPhase = ''
    export hardeningDisable=all
    make -C test/sqlite
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp validate $out/bin/validate
  '';
}
