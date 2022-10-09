#!/usr/bin/env bash
set -e

WORKD_DIR=$(git rev-parse --show-toplevel)
# Custom build script in workspace ?
if [[ -f "$WORKD_DIR/build.sh" ]]; then
    cd $WORKD_DIR
    ./build.sh $1

    exit 0
fi

echo "No build.sh was found in root dir: $WORKD_DIR"
