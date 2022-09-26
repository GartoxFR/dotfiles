#!/usr/bin/env bash
set -e

WORKD_DIR=$(git rev-parse --show-toplevel)
pushd $WORKD_DIR
cargo run 
popd
