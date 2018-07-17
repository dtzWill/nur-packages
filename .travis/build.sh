#!/bin/sh

#cachix push allvm --watch-store &

nix-build ./.travis/test-release.nix -o result #| cachix push allvm

#cachix push allvm ./result
