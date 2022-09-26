#!/usr/bin/env bash
set -e

WORKD_DIR=$(git rev-parse --show-toplevel)

# Custom build script in workspace ?
if [[ -f "$WORKD_DIR/build.sh" ]]; then
    cd $WORKD_DIR
    ./build.sh $1

    exit 0
fi

BUILD_DIR=$WORKD_DIR/build/Debug

mkdir -p $BUILD_DIR
cd $BUILD_DIR
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ../../ && make 

if ! [[ -f "$WORKD_DIR/program_link" ]]; then
    EXE=$(find $(pwd) -type f -executable | fzf)
    ln -sf $EXE $WORKD_DIR/program_link
fi

cd $WORKD_DIR
clear
$WORKD_DIR/program_link
