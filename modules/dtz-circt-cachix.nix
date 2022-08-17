{ lib, pkgs, ... }:

with lib;

{
  config = {
    nix = {
      binaryCaches = [
        "https://dtz-circt.cachix.org"
      ];
      binaryCachePublicKeys = [
        "dtz-circt.cachix.org-1:PHe0okMASm5d9SD+UE0I0wptCy58IK8uNF9P3K7f+IU="
      ];
    };
  };
}
