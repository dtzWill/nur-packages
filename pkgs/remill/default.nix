{ stdenv, fetchFromGitHub, buildEnv,
cmake,
llvm, clang,
python2Packages,
protobuf,
intelxed,
glog,
google-gflags,
gtest,
}:

with stdenv.lib;
let
  llvm_version = getVersion llvm;
  srcinfo = {
    version = "2018-05-21";
    src = fetchFromGitHub {
      owner = "trailofbits";
      repo = "remill";
      rev = "cdfb41a89da483c2e6ce8f246f084cc3d8b171b5";
      sha256 = "0lwg41x3szavqyx8d7zy22znx0qnrzvwgzbpn416ii9ib5rzx1zl";
    };
  };
  mcsema_srcinfo = import ./mcsema.nix { inherit fetchFromGitHub; };

  python-protobuf = python2Packages.protobuf.override { inherit protobuf; };
  python = python2Packages.python;

  remill-bins = with srcinfo; stdenv.mkDerivation rec {
    name = "remill-bins-${version}";
    inherit version src;

    enableParallelBuilding = true;
    hardeningDisable = [ "all" ];

    postUnpack = ''
      unpackFile ${mcsema_srcinfo.src}
      chmod u+rw -R mcsema-* remill-*
      mv mcsema-* $sourceRoot/tools/mcsema
    '';

    postPatch = ''
      substituteInPlace CMakeLists.txt \
        --replace "find_package(XED REQUIRED)" ""
      for x in tests/{AArch64,X86}/CMakeLists.txt; do
      substituteInPlace $x \
        --replace "find_package(gtest REQUIRED)" ""
      done

      # This keeps the chrpath command, don't do that for now
      # sed -i CMakeLists.txt -e 's|\(.*\)COMMAND ''${CHRPATH_COMMAND}|\1COMMAND chmod u+w ''${output_file_path}\n\0|'

      # This drops the chrpath command (comments it out)
      # since their invocation doesn't accomodate existing rpath value
      sed -i CMakeLists.txt -e 's|\(.*\)COMMAND ''${CHRPATH_COMMAND}|\1COMMAND chmod u+w ''${output_file_path}\n# \0|'

      sed -i -e '/CODE/,+2d' tools/mcsema/CMakeLists.txt
      substituteInPlace tools/mcsema/CMakeLists.txt \
      --replace ' ''${CMAKE_CURRENT_SOURCE_DIR}/tools/mcsema_disass/ida' ' ''${CMAKE_INSTALL_PREFIX}/gen/CFG_pb2.py'
    '';

    preConfigure = ''
      export LLVM_DIR=${llvm}
    '';

    cmakeFlags = [
      "-DXED_INCLUDE_DIRS=${intelxed}/include"
      "-DXED_LIBRARIES=${intelxed}/lib/libxed.so;${intelxed}/lib/libxed-ild.so"
    ];

    postInstall = ''
      chmod +rx $out/bin/*
    '';

    nativeBuildInputs = [ cmake ];
    buildInputs = [
      llvm clang
      python python-protobuf protobuf
      intelxed
      glog google-gflags gtest
    ];

    doInstallCheck = false;
    installCheckPhase = ''
      make build_x86_tests
      make test
    '';

    passthru = { inherit mcsema_srcinfo; };
  };

  remill-mcsema-py = with mcsema_srcinfo; python2Packages.buildPythonApplication rec {
    name = "remill-mcsema-py-${version}";
    inherit src version;

    preConfigure = ''
      cp ${remill-bins}/gen/* tools/mcsema_disass/ida/

      sed -i 's,import itertools,import itertools\nimport site\nsite.addsitedir("${python-protobuf}/lib/${python.libPrefix}/site-packages")\nsite.addsitedir("${python2Packages.python_magic}/lib/${python.libPrefix}/site-packages")\nsite.addsitedir("${python2Packages.six}/lib/${python.libPrefix}/site-packages"),' tools/mcsema_disass/ida/get_cfg.py
      cd tools
    '';

    buildInputs = [ python-protobuf python2Packages.python_magic ];
  };
in
  # Merge things together into unified 'mcsema':
  (buildEnv {
    name = "remill-${srcinfo.version}";
    paths = [ remill-bins remill-mcsema-py ];
  }) // srcinfo
  // { bins = remill-bins; py = remill-mcsema-py; } # kludge to make these accessible via 'projects.mcsema.bins' and similar
