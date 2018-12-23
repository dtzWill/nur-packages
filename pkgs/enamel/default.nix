{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "enamel-${version}";
  version = "2018-12-22";

  src = fetchFromGitHub {
    owner = "vhdirk";
    repo = "enamel";
    rev = "1bff1f498eb64ba173851cf75172c54be037939a";
    sha256 = "1qw1qymrnx1ac0qk95q84jq25h41a64whmfmxdv9yrxwfhs3fqnb";
  };

  cargoPatches = [
    ./0001-Don-t-look-for-deps-locally-that-don-t-generally-exi.patch
    ./0002-Cargo.lock-init.patch
  ];

  cargoSha256 = "1hlm1pp9917ri9xr72qg43yx7cf2g4hx3gx060cr102czj06c4i1";
}

