#!/usr/bin/env bash

# based on scripts in /engine/src/flutter/testing/scenario_app
# and xcode_backend.sh script for integration in xcode


# Exit on error
set -e

export FLUTTER_LOCAL_ENGINE=/Users/Aleksandr_Denisov/Work/original_engine/src

if [ "$1" == "release" ]; then
	echo "Coping Flutter.framework (release)..."
	DEVICE_TOOLS=$FLUTTER_LOCAL_ENGINE/out/ios_release/clang_x64
elif [[ "$1" == "debug_sim" ]] ; then
	echo "Coping Flutter.framework (debug-simulator)..."
	DEVICE_TOOLS=$FLUTTER_LOCAL_ENGINE/out/ios_debug_sim_unopt/clang_x64
else
	#debug
	echo "Coping Flutter.framework (debug)..."
	DEVICE_TOOLS=$FLUTTER_LOCAL_ENGINE/out/ios_debug_unopt/clang_x64
fi


OUTDIR=$PWD/Flutter

rm -rf "$OUTDIR/Flutter.framework"
cp -R "$DEVICE_TOOLS/../Flutter.framework" "$OUTDIR"


