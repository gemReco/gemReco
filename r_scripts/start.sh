#!/bin/bash

# Start Rserve

set -e
set -u

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

BIN_FILE=/Library/Frameworks/R.framework/Resources/library/Rserve/libs/Rserve-bin.so
SCRIPT_PATH=$(realpath $(dirname $0))
CONFIG="rserve.conf"

cd $SCRIPT_PATH
R CMD "$BIN_FILE" --no-save --RS-conf "$CONFIG"
