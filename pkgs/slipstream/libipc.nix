{ stdenv, fetchgit, boost, slipstream-ipcd, enableDebugLogging ? false }:

with import ./src.nix;
stdenv.mkDerivation rec {
  name = "slipstream-libipc-${version}";
  inherit version;
  src = fetchgit srcinfo;

  sourceRoot=''${src.name}/libipc'';

  buildInputs = [ boost slipstream-ipcd ];

  patchPhase = ''
    sed -i 's,/bin/ipcd,${slipstream-ipcd}/bin/ipcd,' ipcd.cpp
  '' + stdenv.lib.optionalString enableDebugLogging ''
    sed -i 's,USE_DEBUG_LOGGER 0,USE_DEBUG_LOGGER 1,' debug.h
  '';

  installPhase = ''
    install -Dm755 {.,$out/lib}/libipc.so
  '';
}
