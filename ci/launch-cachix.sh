#!/bin/sh

set -eu

${CACHIX_CACHE:-allvm}

cachix push ${CACHIX_CACHE} --watch-store &
