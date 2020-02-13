{ stdenv, runCommandNoCC, lib }:

let
  versionSuffix = "dtz-mux-210c04c";
  version = "2.4" + versionSuffix;
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/0ec757ed667e2f1aa4a5f902badb23c5adee31d3b5c703e9ac327c96601a6b0c.nar.xz";
    narHash = "sha256:1dxl977wrn4lrmjm95yzaabd0h961q7sj1jdkfvna2k1bfb468q4";
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
