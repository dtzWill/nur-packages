{ stdenv, runCommandNoCC, lib }:

let
  versionSuffix = "dtz-mux-9ed40da";
  version = "2.4" + versionSuffix;
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/a8aca8a705e14b10015a84089a2f91c6467accba7f6f02a58f24e9d6b94100b9.nar.xz";
    narHash = "sha256:1pqldss9kz9q061g2nq7bxjap7c9l6ayh4as483dpnbbmdazjb5s";
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
