{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-dd888e6";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/d20d8082187b27c12465778d0a993f1b5f5742ae42ce47b676c38830e3302047.nar.xz";
    narHash = "sha256:093dcyj8a68ypa3458lxif7ysq527377wjd2332ral6vr01js4r5";
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
