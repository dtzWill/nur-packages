{ stdenv, runCommandNoCC, lib }:

let
  version = "2.3dtz-mux-ed8733d";
  nix-mux-tarball = lib.from-nar {
    name = "nix-${version}";
    narurl = "nar/49ab20f5c9d5f382779edd6bc29d0073a769341032568b816f0dcf305590ca3d.nar.xz";
    narHash = "sha256:0a8ig0y8sl0hplys06csq3wqyk7y3yq1zpcg68nzd6ycy2gvxbs2";
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
