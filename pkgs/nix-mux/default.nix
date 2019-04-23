{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-ed8733d";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/38ac9e18cbc963a0353a5b5a1a14bcf0bbbbf02d0fdde61ed185875f1b6bd31c.nar.xz";
    narHash = "sha256:1x0b69q18ms2jc9qn5b4vdh5li5l3p6hhc5di3hf9l8p3b4hpi02";
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
