{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-b9460c2";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/5ee41afc4eb284ae4c8d5f371e39803dc42d32eb3836c1d614124b1b4bee596c.nar.xz";
    narHash = "sha256:0c5d0cbwschh0m2rz38d86q9lmvbw973d5n5fcr420n55aj9qhr2";
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
