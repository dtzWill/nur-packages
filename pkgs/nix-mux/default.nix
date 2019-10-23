{ stdenv, runCommandNoCC, lib }:

let
  versionSuffix = "dtz-mux-7441fce";
  version = "2.4" + versionSuffix;
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/3c3d879e612a6403b3fd7ef1d5c4592a154b1e4b432d33349d5948b58d1a23b5.nar.xz";
    narHash = "sha256:0fwgb1p9mhz1l9rm9p3aj2y2vdj080mcpb21zmxapbihnqbzb3as";
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
