{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-59ac13b";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/22d94aeb9852529ac97183b0eeec1982a5e178312fcad10db643a7431e2fa99a.nar.xz";
    narHash = "sha256:07wp94hsjh11pay3c4hfky5dgnp91542d0l78jd54csgglwb5h9a";
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
