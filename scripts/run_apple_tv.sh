set -x

#added all scripts here to run appletv locally from one script

# set your own path to custom engine here
export FLUTTER_LOCAL_ENGINE=/Users/Aleksandr_Denisov/Work/original_engine/src

# Clean old mess
fvm flutter clean

#build for ios
fvm flutter pub get
fvm flutter build ios

#move ios tvos folders
sh scripts/switch_target.sh tvos

cd ios

sh ../scripts/copy_framework.sh debug_sim FLUTTER_LOCAL_ENGINE

fvm flutter pub get

#pod install

#add local engine in xcode project
sed -i '' "s#FLUTTER_LOCAL_ENGINE[[:space:]]=[[:space:]].*;#FLUTTER_LOCAL_ENGINE = \"${FLUTTER_LOCAL_ENGINE}\";#g" Runner.xcodeproj/project.pbxproj

open Runner.xcworkspace
