{
substituter ? "https://allvm.cachix.org",
name,
narurl,
narHash
}:

import <nix/fetchurl.nix> {
  url = "${substituter}/${narurl}";
  unpack = true;
  name = "allvm-tools-bins";

  sha256 = narHash; # downloadHash;
}

