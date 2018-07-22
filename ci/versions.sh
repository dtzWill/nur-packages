#!/bin/sh

set -eu

nix --version
readlink -f $(nix-instantiate --find-file nixpkgs)

nix eval --raw nixpkgs.lib.nixpkgsVersion

