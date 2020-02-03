{ stdenv, fetchgit, json_c, libubox, ubus, uci, lua5_1, libnl }:

stdenv.mkDerivation rec {
  pname = "iwinfo";
  version = "2020-01-29";

  src = fetchgit {
    url = "https://git.openwrt.org/project/${pname}.git";
    rev = "bb216982951698833bbdf4a88872e9b5ccd026a5";
    sha256 = "0330l6vjlcmmq3qcii59ikqz342qvvy8hf86wd63n0vhkfifhhx0";
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
