#!/usr/bin/env bash

# based on scripts in /engine/src/flutter/testing/scenario_app
# and xcode_backend.sh script for integration in xcode


# Exit on error
set -e

debug_sim=""

BuildAppDebug() {

  if [[ "$debug_sim" == "true" ]]; then
    if [[ "$cpu_arch" == "arm64" ]]; then
      DEVICE_TOOLS=$FLUTTER_LOCAL_ENGINE/out/ios_debug_sim_unopt_arm64/clang_x64
    else  
      DEVICE_TOOLS=$FLUTTER_LOCAL_ENGINE/out/ios_debug_sim_unopt/clang_x64
    fi
  else
    DEVICE_TOOLS=$FLUTTER_LOCAL_ENGINE/out/ios_debug_unopt/clang_x64
  fi

  if [[ "$cpu_arch" == "arm64" ]]; then
    HOST_TOOLS=$FLUTTER_LOCAL_ENGINE/out/host_debug_unopt_arm64
    gen_snapshot_command="$DEVICE_TOOLS/gen_snapshot_arm64"
  else
    HOST_TOOLS=$FLUTTER_LOCAL_ENGINE/out/host_debug_unopt
    gen_snapshot_command="$DEVICE_TOOLS/gen_snapshot"
  fi


  ROOTDIR=$(dirname "$PROJECT_DIR")
  OUTDIR=$ROOTDIR/build/ios/Debug-iphonesimulator
  mkdir -p $OUTDIR


  echo " └─Coping Flutter.framework"
  rm -rf "$OUTDIR/Flutter.framework"
  cp -R "$DEVICE_TOOLS/../Flutter.framework" "$OUTDIR"


  tvos_deployment_target="$TVOS_DEPLOYMENT_TARGET"

#  echo " └─Copy resourcse images & fonts"
#  mkdir -p "$OUTDIR/App.framework/flutter_assets"
#  cp -v -R "$PROJECT_DIR/tvos_flutter_assets/flutter_assets" "$OUTDIR/App.framework"

  engine_dart_version=$(cat $HOST_TOOLS/dart-sdk/version)
  echo " └─Engine dart version $engine_dart_version"

  echo " └─Compiling kernal"

  "$HOST_TOOLS/dartaotruntime" \
    "$HOST_TOOLS/gen/frontend_server_aot.dart.snapshot" \
    --sdk-root "$HOST_TOOLS/flutter_patched_sdk" \
    --tfa --target=flutter \
    -DTV_MODE=ON \
    --output-dill "$OUTDIR/App.framework/flutter_assets/kernel_blob.bin" \
    "$FLUTTER_APPLICATION_PATH/lib/main.dart"


  echo " └─Compiling JIT Snapshot"

  "$gen_snapshot_command" --deterministic \
    --enable-asserts \
    --isolate_snapshot_instructions="$OUTDIR/isolate_snapshot_instr" \
    --snapshot_kind=app-jit \
    --load_vm_snapshot_data="$DEVICE_TOOLS/../gen/flutter/lib/snapshot/vm_isolate_snapshot.bin" \
    --load_isolate_snapshot_data="$DEVICE_TOOLS/../gen/flutter/lib/snapshot/isolate_snapshot.bin" \
    --isolate_snapshot_data="$OUTDIR/App.framework/flutter_assets/isolate_snapshot_data" \
    --isolate_snapshot_instructions="$OUTDIR/App.framework/flutter_assets/isolate_snapshot_instr" \
    "$OUTDIR/App.framework/flutter_assets/kernel_blob.bin"

  cp "$DEVICE_TOOLS/../gen/flutter/lib/snapshot/vm_isolate_snapshot.bin" "$OUTDIR/App.framework/flutter_assets/vm_snapshot_data"


  if [[ "$debug_sim" == "true" ]]; then
    SYSROOT=$(xcrun --sdk appletvsimulator --show-sdk-path)
  else
    SYSROOT=$(xcrun --sdk appletvos --show-sdk-path)
  fi

  echo " └─Creating stub App using $SYSROOT"


  if [[ "$debug_sim" == "true" ]]; then
    if [[ "$cpu_arch" == "arm64" ]]; then
       echo "static const int Moo = 88;" | xcrun clang -x c \
      -arch arm64 \
      -L"$SYSROOT/usr/lib" \
      -lSystem \
      -isysroot "$SYSROOT" \
      -mtvos-version-min=$tvos_deployment_target \
      -dynamiclib \
      -Xlinker -rpath -Xlinker '@executable_path/Frameworks' \
      -Xlinker -rpath -Xlinker '@loader_path/Frameworks' \
      -install_name '@rpath/App.framework/App' \
      -o "$OUTDIR/App.framework/App" -
    else  
       echo "static const int Moo = 88;" | xcrun clang -x c \
      -arch x86_64 \
      -L"$SYSROOT/usr/lib" \
      -lSystem \
      -isysroot "$SYSROOT" \
      -mtvos-version-min=$tvos_deployment_target \
      -dynamiclib \
      -Xlinker -rpath -Xlinker '@executable_path/Frameworks' \
      -Xlinker -rpath -Xlinker '@loader_path/Frameworks' \
      -install_name '@rpath/App.framework/App' \
      -o "$OUTDIR/App.framework/App" -
    fi
   

  else    
    echo "static const int Moo = 88;" | xcrun clang -x c \
      -arch arm64 \
      -isysroot "$SYSROOT" \
      -mtvos-version-min=$tvos_deployment_target \
      -dynamiclib \
      -Xlinker -rpath -Xlinker '@executable_path/Frameworks' \
      -Xlinker -rpath -Xlinker '@loader_path/Frameworks' \
      -install_name '@rpath/App.framework/App' \
      -o "$OUTDIR/App.framework/App" -
  fi

  strip "$OUTDIR/App.framework/App"

  echo "copy frameworks"
  cp "$PROJECT_DIR/../scripts/Info.plist" "$OUTDIR/App.framework/Info.plist" 

  cp -R "${OUTDIR}/"{App.framework,Flutter.framework} "$TARGET_BUILD_DIR"

  echo " └─Sign"
  if [[ "$debug_sim" != "true" ]]; then
    codesign --force --verbose --sign "${EXPANDED_CODE_SIGN_IDENTITY}" -- "${TARGET_BUILD_DIR}/App.framework/App"
    codesign --force --verbose --sign "${EXPANDED_CODE_SIGN_IDENTITY}" -- "${TARGET_BUILD_DIR}/Flutter.framework/Flutter"
  fi

  echo " └─Done"

  return 0
}


BuildAppRelease() {

  DEVICE_TOOLS=$FLUTTER_LOCAL_ENGINE/out/ios_release/clang_x64

  if [[ "$cpu_arch" == "arm64" ]]; then
    HOST_TOOLS=$FLUTTER_LOCAL_ENGINE/out/host_release_arm64
    gen_snapshot_command="$DEVICE_TOOLS/gen_snapshot_arm64"
  else
    HOST_TOOLS=$FLUTTER_LOCAL_ENGINE/out/host_release
    gen_snapshot_command="$DEVICE_TOOLS/gen_snapshot"
  fi

  ROOTDIR=$(dirname "$PROJECT_DIR")
  OUTDIR=$ROOTDIR/build/ios/Debug-iphonesimulator
  mkdir -p $OUTDIR

  echo " └─Coping Flutter.framework"
  rm -rf "$OUTDIR/Flutter.framework"
  cp -R "$DEVICE_TOOLS/../Flutter.framework" "$OUTDIR"

  tvos_deployment_target="$TVOS_DEPLOYMENT_TARGET"

#  echo " └─Copy resourcse images & fonts"
#  mkdir -p "$OUTDIR/App.framework/flutter_assets"
#  cp -R "$PROJECT_DIR/tvos_flutter_assets/flutter_assets" "$OUTDIR/App.framework"

  engine_dart_version=$(cat $HOST_TOOLS/dart-sdk/version)
  echo " └─Engine dart version $engine_dart_version"

  echo " └─Compiling kernal"

  "$HOST_TOOLS/dartaotruntime" -v \
    "$HOST_TOOLS/gen/frontend_server_aot.dart.snapshot" \
    --sdk-root "$HOST_TOOLS/flutter_patched_sdk" \
    --aot --tfa --target=flutter \
    -DTV_MODE=ON \
    --output-dill "$OUTDIR/app.dill" \
    "$FLUTTER_APPLICATION_PATH/lib/main.dart"

  echo " └─Compiling AOT Assembly"

  "$gen_snapshot_command" \
    --deterministic \
    --snapshot_kind=app-aot-assembly \
    --assembly=$OUTDIR/snapshot_assembly.S $OUTDIR/app.dill


  echo " └─Compiling Assembly"

  SYSROOT=$(xcrun --sdk appletvos --show-sdk-path)

  cc -arch arm64 \
    -fembed-bitcode \
    -isysroot "$SYSROOT" \
    -mtvos-version-min=$tvos_deployment_target \
    -c "$OUTDIR/snapshot_assembly.S" \
    -o "$OUTDIR/snapshot_assembly.o"

  echo " └─Linking app"

  clang -v -arch arm64 \
    -fembed-bitcode \
    -isysroot "$SYSROOT" \
    -mtvos-version-min=$tvos_deployment_target \
    -dynamiclib -Xlinker -rpath -Xlinker @executable_path/Frameworks \
    -Xlinker -rpath -Xlinker @loader_path/Frameworks \
    -install_name @rpath/App.framework/App \
    -o "$OUTDIR/App.framework/App" \
    "$OUTDIR/snapshot_assembly.o"


  strip "$OUTDIR/App.framework/App"

  cp "$PROJECT_DIR/../scripts/Info.plist" "$OUTDIR/App.framework/Info.plist" 
  
  echo "copy frameworks"
  cp -R "${OUTDIR}/"{App.framework,Flutter.framework} "$BUILT_PRODUCTS_DIR"
  
  # Sign the binaries we moved.
  codesign --force --verbose --sign "${EXPANDED_CODE_SIGN_IDENTITY}" -- "${BUILT_PRODUCTS_DIR}/App.framework/App"
  codesign --force --verbose --sign "${EXPANDED_CODE_SIGN_IDENTITY}" -- "${BUILT_PRODUCTS_DIR}/Flutter.framework/Flutter"

  echo " └─Done"

  return 0

}


BuildApp() {
  
  local build_mode="$(echo "${FLUTTER_BUILD_MODE:-${CONFIGURATION}}" | tr "[:upper:]" "[:lower:]")"

  local cpu_arch="$(uname -m)"
  
  echo "Compling /Flutter/App.Framework $cpu_arch"
 
  if [ -z "$FLUTTER_LOCAL_ENGINE" ]; then
    echo " └─ERROR: FLUTTER_LOCAL_ENGINE not set!" 
    return 1;
  fi

  echo " └─engine $FLUTTER_LOCAL_ENGINE"

  echo "Build Mode $build_mode"

  if [[ "$PLATFORM_NAME" == "appletvsimulator" && "$build_mode" =~ "debug" ]]; then
    debug_sim="true"
    BuildAppDebug
  elif [[ "$build_mode" =~ "debug" ]]; then
    BuildAppDebug
  elif [[ "$build_mode" =~ "release" ]]; then
    # release/archive   (archive: build mode == "release" && ${ACTION} == "install")
    BuildAppRelease
  else
    echo " └─ERROR: unknown target: ${build_mode}" 
    return 1;
  fi

  return 0
}


# Main entry point.
if [[ $# == 0 ]]; then
  # Backwards-compatibility: if no args are provided, build and embed.
  BuildApp
  EmbedFlutterFrameworks
else
  case $1 in
    "build")
      BuildApp ;;
    *)
     echo "Invalid argument: ${1}"
    ;;
    esac
fi
