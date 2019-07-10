{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-d55440c";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/0cc6805d9710777beeb71f0da948edaf50e20a5aee624774ae95e732c211d9df.nar.xz";
    narHash = "sha256:0p20lzb7fma4rgv4ypdmcicilgwkx6401zbs4vkbng7cgn5g5z68";
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
