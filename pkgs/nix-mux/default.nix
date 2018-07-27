{ stdenv, runCommandNoCC, lib }:

let
  version = "2.1dtz-mux-f9c10e7";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/a43ad0f6efa6402d332fb6d46896f018c77c225959d9b5718411ec1771963203.nar.xz";
    narHash = "sha256:10ac9wml9hdqm9krjk7yvps8dmwmwygrnm0qvgc2xv5rj0lapwj6";
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
