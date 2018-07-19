{ stdenv
, cmake
, llvm
, clang # tests
, fetchFromGitHub
, checkWithOtherPTAs ? false # They don't pass tests but potentially interesting.
, doCheck ? true
}:

let
  llvm_version = if (llvm ? release_version) then llvm.release_version else (builtins.parseDrvName llvm.name).version;
in
stdenv.mkDerivation rec {
  version = "2018-05-16"; # Date of commit used
  name = "dg_llvm${llvm_version}-${version}";
  src = fetchFromGitHub {
    owner = "mchalupa";
    repo = "dg";
    rev = "ab728741046f011040b1b222fa97872866eb9883";
    sha256 = "1v8yc0av567w6wg1a4np7sn4mll7256f8sc84p6kzhi1arfx4x2i";
  };

  enableParallelBuilding = true;

  dontUseCmakeBuildDir = true;

  prePatch = ''
    patchShebangs .

    substituteInPlace tools/git-version.sh --replace '`git rev-parse --short=8 HEAD`' ${builtins.substring 0 7 src.rev}

    substituteInPlace src/llvm/analysis/PointsTo/PointerSubgraph.cpp \
      --replace 'static_assert(sizeof(Offset::type) == sizeof(uint64_t))' \
                'static_assert(sizeof(Offset::type) == sizeof(uint64_t), "offset type must be uint64_t")'
  '';

  cmakeFlags = [
    "-DLLVM_ENABLE_ASSERTIONS=ON"
    "-DLLVM_DIR=${llvm}"
  ];

  # Install other utilities as well
  postPatch = ''
    substituteInPlace tools/CMakeLists.txt \
      --replace "install(TARGETS" "install(TARGETS llvm-ps-dump llvm-rd-dump llvm-to-source llvm-pta-compare"
  '';

  inherit doCheck;

  checkPhase = ''
    # Workaround so tests can find the just-built libs before installation
    export LD_LIBRARY_PATH=$PWD/src:$LD_LIBRARY_PATH

    # Run tests in parallel
    export CTEST_PARALLEL_LEVEL=$NIX_BUILD_CORES

    # Don't add magic hardening CFLAGS to clang while testing!
    export hardeningDisable=all

    # Do default tests, ctest stuff but also other things
    make check
  '' + stdenv.lib.optionalString checkWithOtherPTAs ''
    # Try other pointer analysis variants
    for pta in fi fs old; do
      export DG_TESTS_PTA=$pta
      echo "Running tests with DG_TESTS_PTA=$DG_TESTS_PTA..."
      make check
    done
  '';

  buildInputs = [ llvm cmake ] ++ stdenv.lib.optional doCheck clang;
}

