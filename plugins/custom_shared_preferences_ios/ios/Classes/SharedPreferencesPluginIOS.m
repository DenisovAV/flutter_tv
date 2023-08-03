#import "SharedPreferencesPluginIOS.h"

static NSString *const CHANNEL_NAME = @"plugins.flutter.io/shared_preferences_ios";

@implementation SharedPreferencesPluginIOS

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:CHANNEL_NAME
                                                              binaryMessenger:registrar.messenger];

  [channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
    NSString *method = [call method];
    NSDictionary *arguments = [call arguments];
    NSString *suiteName = arguments[@"suiteName"];
    NSUserDefaults *instance = [suiteName isEqual:[NSNull null]] ? [NSUserDefaults standardUserDefaults] : [[NSUserDefaults alloc] initWithSuiteName:suiteName];

    if ([method isEqualToString:@"getAll"]) {
      result(getAllPrefs(suiteName));
    } else if ([method isEqualToString:@"setBool"]) {
      NSString *key = arguments[@"key"];
      NSNumber *value = arguments[@"value"];
      [instance setBool:value.boolValue forKey:key];
      result(@YES);
        
    } else if ([method isEqualToString:@"setInt"]) {
      NSString *key = arguments[@"key"];
      NSNumber *value = arguments[@"value"];     
      [instance setValue:value forKey:key];
      result(@YES);
        
    } else if ([method isEqualToString:@"setDouble"]) {
      NSString *key = arguments[@"key"];
      NSNumber *value = arguments[@"value"];
      [instance setDouble:value.doubleValue forKey:key];
      result(@YES);
        
    } else if ([method isEqualToString:@"setString"]) {
      NSString *key = arguments[@"key"];
      NSString *value = arguments[@"value"];  
      [instance setValue:value forKey:key];
      result(@YES);
        
    } else if ([method isEqualToString:@"setStringList"]) {
      NSString *key = arguments[@"key"];
      NSArray *value = arguments[@"value"];      
      [instance setValue:value forKey:key];
      result(@YES);
        
    } else if ([method isEqualToString:@"commit"]) {
      // synchronize is deprecated.
      // "this method is unnecessary and shouldn't be used."
      result(@YES);
        
    } else if ([method isEqualToString:@"remove"]) {
      [instance removeObjectForKey:arguments[@"key"]];
      result(@YES);
        
    } else if ([method isEqualToString:@"clear"]) {
      for (NSString *key in getAllPrefs(suiteName)) {
        [instance removeObjectForKey:key];
      }
      result(@YES);
        
    } else if ([method isEqualToString:@"getAppGroup"]) {
      NSBundle *bundle = [NSBundle mainBundle];
      NSString *appgroup = [bundle objectForInfoDictionaryKey: @"APP_GROUP"];
      result(appgroup);

    } else {
      result(FlutterMethodNotImplemented);
    }
  }];
}

#pragma mark - Private

static NSMutableDictionary *getAllPrefs(NSString *suiteName) {
  NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
  NSDictionary *prefs =
     [suiteName isEqual:[NSNull null]] ? [[NSUserDefaults standardUserDefaults] persistentDomainForName:appDomain] : [[[NSUserDefaults alloc] initWithSuiteName:suiteName]  dictionaryRepresentation];
  NSMutableDictionary *filteredPrefs = [NSMutableDictionary dictionary];
  if (prefs != nil) {
    for (NSString *candidateKey in prefs) {
      if ([candidateKey hasPrefix:@"flutter."]) {
        [filteredPrefs setObject:prefs[candidateKey] forKey:candidateKey];
      }
    }
  }
  return filteredPrefs;
}

@end
