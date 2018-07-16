{ stdenv, fetchgit, buildGoPackage }:

with import ./src.nix;
buildGoPackage rec {
  name = "slipstream-ipcd-${version}";
  inherit version;
  src = fetchgit srcinfo;

  goPackagePath = "github.com/dtzWill/ipcopter"; # (?)

  doCheck = false; # TODO: Fix path to 'ipcd' binary used in testing...?

  # goDeps = ./deps.nix;
}
