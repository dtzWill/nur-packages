{ pkgs, lib, fetchFromGitHub, sassc, glib, gtk3, notmuch, libsoup, gmime3 }:

# :(
let
  mozilla-overlay-src = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    # commit from: 2018-03-27
    rev = "2945b0b6b2fd19e7d23bac695afd65e320efcebe";
    sha256 = "034m1dryrzh2lmjvk3c0krgip652dql46w5yfwpvh7gavd3iypyw";
  };
in
with import "${mozilla-overlay-src.out}/rust-overlay.nix" pkgs pkgs;
#stdenv.mkDerivation {
#  name = "rust-env";
#  buildInputs = [
#    # Note: to use use stable, just replace `nightly` with `stable`
#    latest.rustChannels.nightly.rust
#
#    # Add some extra dependencies from `pkgs`
#    pkgconfig openssl
#  ];
#
#  # Set Environment Variables
#  RUST_BACKTRACE = 1;
#}
let
  rustPlatform = pkgs.makeRustPlatform {
    cargo = latest.rustChannels.nightly.rust;
    rustc = latest.rustChannels.nightly.rust;
  };
in rustPlatform.buildRustPackage rec {
  name = "enamel-${version}";
  version = "2018-12-22";

  src = fetchFromGitHub {
    owner = "vhdirk";
    repo = "enamel";
    rev = "1bff1f498eb64ba173851cf75172c54be037939a";
    sha256 = "1qw1qymrnx1ac0qk95q84jq25h41a64whmfmxdv9yrxwfhs3fqnb";
  };

  buildInputs = [ sassc glib gtk3 notmuch libsoup gmime3 ];

  cargoPatches = [
    ./0001-Don-t-look-for-deps-locally-that-don-t-generally-exi.patch
    ./0002-Cargo.lock-init.patch
  ];

  cargoSha256 = "1hlm1pp9917ri9xr72qg43yx7cf2g4hx3gx060cr102czj06c4i1";
}

