#import "NativeVideoPlayerPlugin.h"
#if __has_include(<custom_native_video_player_ios/custom_native_video_player_ios-Swift.h>)
#import <custom_native_video_player_ios/custom_native_video_player_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "custom_native_video_player_ios-Swift.h"
#endif

@implementation NativeVideoPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftNativeVideoPlayerPlugin registerWithRegistrar:registrar];
}
@end
