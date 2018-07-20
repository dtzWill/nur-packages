{ stdenv, runCommandNoCC, lib }:

let
  nix-mux-tarball = lib.from-nar {
    name = "nix-mux";
    narurl = "nar/f616c55cc6067fcce440abe5255ca7307533726773491426dd8ebcb92cc8ad22.nar.xz";
    narHash = "sha256:1p5vzz6hv0r96qi78jb8f72c3yinj4phd16ksn6dlrs7pcnv7gc5";
  };

  bootstrapFiles = {
    # TODO: better way of grabbing this
    busybox = stdenv.bootstrapTools.builder;

    tarball = nix-mux-tarball;
  };

  unpack = import ./unpack.nix {
    inherit (stdenv.hostPlatform) system;
    inherit bootstrapFiles;
  };
in
  unpack
  
