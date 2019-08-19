{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-8749581";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/022ef0f870ad3417e99835a9b08ceecc572f2f16523848f93e9c58eb0d6b5b9b.nar.xz";
    narHash = "sha256:07l89vd522ysl4vbf5hw4zmkymmdsfpm3bfp3zq0wjw7cppxavdv";
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
