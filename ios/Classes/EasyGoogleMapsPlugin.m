#import "EasyGoogleMapsPlugin.h"
#if __has_include(<easy_google_maps/easy_google_maps-Swift.h>)
#import <easy_google_maps/easy_google_maps-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "easy_google_maps-Swift.h"
#endif

@implementation EasyGoogleMapsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEasyGoogleMapsPlugin registerWithRegistrar:registrar];
}
@end
