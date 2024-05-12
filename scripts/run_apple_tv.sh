#!/bin/bash
# Usage: ./run_apple_tv.sh [ENGINE_TYPE]
#  ENGINE_TYPE: 
#  'debug_sim' - engine for x86_64 Mac apple tv simulator
#  'debug_sim_arm64' - engine for arm64 Mac apple tv simulator
#  'debug' - engine for real apple tv device, debug mode
#  'release' - engine for real apple tv device, release mode

# engine_type is optional, defaults to 'debug_sim_arm64'

set -x

#added all scripts here to run appletv locally from one script

ENGINE_TYPE=${1:-debug_sim_arm64}

# set your own path to custom engine here
export FLUTTER_LOCAL_ENGINE=/Users/Aleksandr_Denisov/Work/engine/src

if [ -d "_ios" ]; then
sh scripts/switch_target.sh ios
fi

# Clean old mess
fvm flutter clean

#build for ios
fvm flutter pub get
fvm flutter build ios --simulator

#move ios tvos folders
sh scripts/switch_target.sh tvos

cd ios

fvm flutter pub get

pod install

sh ../scripts/copy_framework.sh $ENGINE_TYPE $FLUTTER_LOCAL_ENGINE

#add local engine in xcode project
sed -i "" "s#FLUTTER_LOCAL_ENGINE[[:space:]]=[[:space:]].*;#FLUTTER_LOCAL_ENGINE = \"${FLUTTER_LOCAL_ENGINE}\";#g" Runner.xcodeproj/project.pbxproj

open Runner.xcworkspace
