{ stdenv, runCommandNoCC, lib }:

let
  versionSuffix = "dtz-mux-522244a";
  version = "2.4" + versionSuffix;
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/dc8d0910f92007c70d96dae95f68c1c81ebb3505644927bc2936ee29c44a7eec.nar.xz";
    narHash = "sha256:14149pnbw4lp3r5gchfsji38xn8sfzay45asm2pw7lfvky51bzqq";
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
