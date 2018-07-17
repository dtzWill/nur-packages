#!/bin/sh

#cachix push allvm --watch-store &

nix-build release.nix -o result #| cachix push allvm

#cachix push allvm ./result
