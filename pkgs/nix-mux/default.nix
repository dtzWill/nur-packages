{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-d251a24";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/f00867171cdf540cef2ff2080170e7f7e6e3b9483964c75b0ef445b8676652f9.nar.xz";
    narHash = "06lsg9v68rfs15979zbi9dgysa593889szq5qj5ih2nqpddy666q";
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
