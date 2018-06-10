#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(SwiftComponentManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(filePath, NSString)
RCT_EXPORT_VIEW_PROPERTY(filterName, NSString)
RCT_EXTERN_METHOD(updateValueViaManager:(nonnull NSNumber *)node filterName:(nonnull NSString *)filterName)

@end

