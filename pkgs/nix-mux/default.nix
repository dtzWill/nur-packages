{ stdenv, runCommandNoCC, lib }:

let
  version = "2.1dtz-mux-698574e";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/c95e61735685a5a94c1b688d3f9d1e78bb52af9988f79dd5e1aaa82c7ff8c438.nar.xz";
    narHash = "sha256:1yl843z915pnac9dwnd3bxdm4am1i1m9x8svl9vvc310w39r5nxl";
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
    maintainers = with maiintainers; [ dtzWill ];
    license = licenses.lgpl2Plus;
    homepage = https://github.com/allvm/allvm-tools;
  };
in
  unpack // { inherit meta; }
