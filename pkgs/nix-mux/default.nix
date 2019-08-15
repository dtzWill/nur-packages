{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-9385070";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/265ab87bba8fcd3c990015b42806621d74d82c476f27884c47bc6feba4cdbcf8.nar.xz";
    narHash = "sha256:0a50fzmhsah6d3q8qy2pp0h442aq48175shnkzk2w4g45d18kvkd";
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
