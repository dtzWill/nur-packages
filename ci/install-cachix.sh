#!/bin/sh

set -eu

nix-env -if https://github.com/NixOS/nixpkgs/tarball/master -A cachix
