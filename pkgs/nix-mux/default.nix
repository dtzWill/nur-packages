{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-8e7326e";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/cb47317efbe458e5b422f2c5bc9f9080debfe0995f033e80335672eac7c4be10.nar.xz";
    narHash = "sha256:1p3a5asfy7lz1idc6ds50cwlwc6kx9icr6vqqx6b5xb0smkqqmdf";
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
