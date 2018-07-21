{ stdenv, runCommandNoCC, lib }:

let
  version = "2.1dtz-mux-b5fd179";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/b779b57e30614c0a689a22d4594508ddfd3060e338182145f55945fb76f0d881.nar.xz";
    narHash = "sha256:0y9vhvqp5ap8qh1m5f5liljd5zp4s6s6ch22d12542d9hmm0lnmm";
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
    maintainers = with maiintainers; [ dtzWill ];
    license = licenses.lgpl2Plus;
    homepage = https://github.com/allvm/allvm-tools;
  };
in
  unpack // { inherit meta; }
