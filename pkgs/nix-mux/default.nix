{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-f006c8a";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/f0472aee4746899c721af16eb8e5aef52036574b41f92489204dda87becb259f.nar.xz";
    narHash = "sha256:1gcs2psfx1d4bzgqyr0pqc3x2bmf12fggnrz2bzqjvf5g03p5msh";
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
