{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-368e4f0";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/a6900be8ef11617c7daca76ba6adaa8214f09910295b1d7750d79dbbb2432556.nar.xz";
    narHash = "sha256:0ki6p0vly4srxjbbwz7pbkkgs833v03xwjmhdbpcwzhygf68nxvq";
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
