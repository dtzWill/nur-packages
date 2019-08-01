{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-2dd6b93";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/119bb1ddd24d9f82e4774e6600ab027c3edbe6ca8ad64a2af27b9acf3e0cf23d.nar.xz";
    narHash = "sha256:1p3lafqjd2az6dpvkvwkjaqh70hi16dnn9fwfbxqb8d061kpd01y";
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
