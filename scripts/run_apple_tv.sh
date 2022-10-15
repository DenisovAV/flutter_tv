set -x

#added all scripts here to run appletv locally from one script

# set your own path to custom engine here
export FLUTTER_LOCAL_ENGINE=/Users/Aleksandr_Denisov/Work/engine/src

# Clean old mess
fvm flutter clean

#build for ios
fvm flutter pub get
fvm flutter build ios

#move ios tvos folders
sh scripts/switch_target.sh tvos

cd ios

#choose the necessary type of the engine
#  'debug_sim' - engine for apple tv simulator
#  'debug' - engine for real apple tv device, debug mode
#  'release' - engine for real apple tv device, release mode

fvm flutter pub get

pod install

sh ../scripts/copy_framework.sh debug_sim FLUTTER_LOCAL_ENGINE

#add local engine in xcode project
sed -i '' "s#FLUTTER_LOCAL_ENGINE[[:space:]]=[[:space:]].*;#FLUTTER_LOCAL_ENGINE = \"${FLUTTER_LOCAL_ENGINE}\";#g" Runner.xcodeproj/project.pbxproj

open Runner.xcworkspace
