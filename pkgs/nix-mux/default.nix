{ stdenv, runCommandNoCC, lib }:

let
  version = "2.2dtz-mux-4446425";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/a43c1ca47cc343f42ea02d8125581f8be300108ce7fddd633bb7ae640a09ebc9.nar.xz";
    narHash = "sha256:005nzr7pw3ds1mb0ni6pyi9bljalvljazf0ykmckiiriwih4s9w9";
  };

  bootstrapFiles = {
    # TODO: better way of grabbing this
    busybox = stdenv.bootstrapTools.builder;

    tarball = nix-mux-tarball;
  };

  unpack = import ./unpack.nix {
    name = "nix-${version}";
    inherit (stdenv.hostPlatform) system;
    inherit bootstrapFiles;
  };

  meta = with lib; {
    description = "Nix All-in-One! (multiplexed)";
    maintainers = with maintainers; [ dtzWill ];
    license = licenses.lgpl2Plus;
    homepage = https://github.com/allvm/allvm-tools;
  };
in
  unpack // { inherit meta; }
