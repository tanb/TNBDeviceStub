//
//  TNBDeviceStub.h
//  TNBDeviceStub
//
//  Created by tanB on 3/31/14.
//  Copyright (c) 2014 tanB. All rights reserved.
//

@class NSString, NSUUID, UIDevice;

@interface TNBDeviceStub : NSObject

@property (nonatomic, retain) NSString *name; // e.g. "My iPhone"
@property (nonatomic, retain) NSString *model; // e.g. @"iPhone", @"iPod touch"
@property (nonatomic, retain) NSString *localizedModel; // localized version of model
@property (nonatomic, retain) NSString *systemName; // e.g. @"iOS"
@property (nonatomic, retain) NSString *systemVersion; // e.g. @"4.0"
@property (nonatomic) UIDeviceOrientation orientation; // return current device orientation.  this will return UIDeviceOrientationUnknown unless device orientation notifications are being generated.
@property (nonatomic, retain) NSUUID *identifierForVendor NS_AVAILABLE_IOS(6_0); // a UUID that may be used to uniquely identify the device, same across apps from a single vendor.
@property (nonatomic, getter=isGeneratingDeviceOrientationNotifications) BOOL generatesDeviceOrientationNotifications;
@property (nonatomic, getter=isBatteryMonitoringEnabled) BOOL batteryMonitoringEnabled NS_AVAILABLE_IOS(3_0);  // default is NO
@property (nonatomic) UIDeviceBatteryState batteryState NS_AVAILABLE_IOS(3_0);  // UIDeviceBatteryStateUnknown if monitoring disabled
@property (nonatomic) float batteryLevel NS_AVAILABLE_IOS(3_0);  // 0 .. 1.0. -1.0 if UIDeviceBatteryStateUnknown
@property (nonatomic, getter=isProximityMonitoringEnabled) BOOL proximityMonitoringEnabled NS_AVAILABLE_IOS(3_0); // default is NO
@property (nonatomic) BOOL proximityState NS_AVAILABLE_IOS(3_0);  // always returns NO if no proximity detector
@property (nonatomic, getter=isMultitaskingSupported) BOOL multitaskingSupported NS_AVAILABLE_IOS(4_0);

@property (nonatomic) UIUserInterfaceIdiom userInterfaceIdiom NS_AVAILABLE_IOS(3_2);

+ (id)currentDevice;
- (void)playInputClick NS_AVAILABLE_IOS(4_2);  // Plays a click only if an enabling input view is on-screen and user has enabled input clicks.
- (BOOL)isMultitaskingSupported;
- (BOOL)isBatteryMonitoringEnabled;
- (void)endGeneratingDeviceOrientationNotifications;
- (void)beginGeneratingDeviceOrientationNotifications;
- (BOOL)isProximityMonitoringEnabled;
- (BOOL)isGeneratingDeviceOrientationNotifications;
@end


@interface TNBDeviceStub (TNBDeviceStubExchange)
+ (void)replace;
+ (void)restore;

- (void)replace;
- (void)restore;
@end

