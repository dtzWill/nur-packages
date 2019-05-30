{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-72b4945";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/7fe382f9a3ee8b5dfcc1f57decf2ff6b40d6b1da7ddd3f7b35eb6188e0409502.nar.xz";
    narHash = "sha256:0vip23g3hq2h91m08bg03557ds48nbfj0rx17jg3y450fnqhfjcf";
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
