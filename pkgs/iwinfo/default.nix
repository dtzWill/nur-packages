{ stdenv, fetchgit, json_c, libubox, ubus, uci, lua5_1, libnl }:

stdenv.mkDerivation rec {
  pname = "iwinfo";
  version = "2020-02-04";

  src = fetchgit {
    url = "https://git.openwrt.org/project/${pname}.git";
    rev = "eba5a204f776f49b9948b41e41c03560dbd307c8";
    sha256 = "04hhalaivj3j969sdmjf0wzfmnrjyix0d5l818fav3cf51x9anb7";
  };

  buildInputs = [ json_c libubox ubus uci lua5_1 libnl ];

  BACKENDS = [ "wl" "nl80211" ];

  NIX_CFLAGS_COMPILE = [
    "-D_GNU_SOURCE=1" # FNM_CASEFOLD
    "-I${libnl.dev}/include/libnl3"
  ];

  postPatch = ''
    substituteInPlace Makefile --replace -lnl-tiny "-lnl-3 -lnl-genl-3"
    substituteInPlace include/iwinfo.h --replace /usr/share $out/share
  '';

  installPhase = ''
    install -Dm755 iwinfo -t $out/bin
    install -Dm755 libiwinfo.so -t $out/lib
    install -D -t $out/share/libiwinfo hardware.txt
  '';
}
