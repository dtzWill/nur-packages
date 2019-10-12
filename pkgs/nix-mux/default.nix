{ stdenv, runCommandNoCC, lib }:

let
  versionSuffix = "dtz-mux-43475a9";
  version = "2.4" + versionSuffix;
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/283fca7654a10b5b9bd0bb3e61472e612b4311ebfce2d00105a87113f846ecda.nar.xz";
    narHash = "sha256:0hhdppkizb8l44d8jhayyq4sgq8vrh18jcmy37fw149y8qnq3f0x";
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
