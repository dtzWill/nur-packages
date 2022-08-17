{ lib, pkgs, ... }:

with lib;

{
  config.nix.settings = {
    substituters = [
      "https://allvm.cachix.org"
    ];
    trusted-public-keys = [
      "allvm.cachix.org-1:nz7VuSMfFJDKuOc1LEwUguAqS07FOJHY6M45umrtZdk="
    ];
  };
}
