{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-25676d3";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/f4ccfc68dcf17bf8484d3a294ce2d16d85aa19e7296d1b5278044e97993dec7a.nar.xz";
    narHash = "sha256:1f1d1frxv7fy4pjiiqc1knc6c3w0q1yc1fb67nczfz98dxk214kv";
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
