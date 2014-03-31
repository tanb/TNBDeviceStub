//
//  TNBDeviceStub.m
//  TNBDeviceStub
//
//  Created by tanB on 3/31/14.
//  Copyright (c) 2014 tanB. All rights reserved.
//

#import "TNBDeviceStub.h"
#import <objc/runtime.h>

@implementation TNBDeviceStub
static TNBDeviceStub *tnb_currentDevice;
static BOOL tnb_device_exchanged;

+ (void)initialize
{
    tnb_device_exchanged = NO;
    tnb_currentDevice = nil;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _model = @"iPhone";
    _orientation = UIDeviceOrientationUnknown;
    _name = @"Stub's iPhone";
    _multitaskingSupported = NO;
    _proximityState = NO;
    _batteryLevel = -1.0;
    _batteryState = UIDeviceBatteryStateUnknown;
    _batteryMonitoringEnabled = NO;
    _systemName = @"iOS";
    _localizedModel = @"iPhone";
    _identifierForVendor = [NSUUID UUID];
    _proximityMonitoringEnabled = NO;
    _systemVersion = @"0.0.0";
    _generatesDeviceOrientationNotifications = NO;
    _userInterfaceIdiom = UIUserInterfaceIdiomPhone;
    
    return self;
}

+ (id)currentDevice
{
    @synchronized(self) {
        if(tnb_currentDevice == nil)
            tnb_currentDevice = [TNBDeviceStub new];
    }
    
    return tnb_currentDevice;
}

- (void)playInputClick
{
    // do nothing.
}

- (BOOL)isMultitaskingSupported
{
    return _multitaskingSupported;
}

- (BOOL)isBatteryMonitoringEnabled
{
    return _batteryMonitoringEnabled;
}

- (void)endGeneratingDeviceOrientationNotifications
{
    // do nothing.
}

- (void)beginGeneratingDeviceOrientationNotifications
{
    // do nothing.
}

- (BOOL)isProximityMonitoringEnabled
{
    return _proximityMonitoringEnabled;
}

- (BOOL)isGeneratingDeviceOrientationNotifications
{
    return _generatesDeviceOrientationNotifications;
}
@end



@implementation TNBDeviceStub (TNBDeviceStubExchange)
+ (void)_exchange
{
    Method origMethod = class_getClassMethod([UIDevice class], @selector(currentDevice));
    Method newMethod = class_getClassMethod([TNBDeviceStub class], @selector(currentDevice));
    
    method_exchangeImplementations(origMethod, newMethod);
    tnb_device_exchanged = !tnb_device_exchanged;
}

+ (void)replace
{
    if (tnb_device_exchanged) {
        return;
    }
    [TNBDeviceStub _exchange];
}

+ (void)restore
{
//    tnb_currentDevice = nil;
    if (!tnb_device_exchanged) {
        return;
    }
    [TNBDeviceStub _exchange];
}

- (void)_exchange
{
    Method origMethod = class_getClassMethod([UIDevice class], @selector(currentDevice));
    Method newMethod = class_getClassMethod([TNBDeviceStub class], @selector(currentDevice));
    
    method_exchangeImplementations(origMethod, newMethod);
    tnb_device_exchanged = !tnb_device_exchanged;
}

- (void)replace
{
    tnb_currentDevice = self;
    if (tnb_device_exchanged) {
        return;
    }
    [self _exchange];
}

- (void)restore
{
    tnb_currentDevice = nil;
    if (!tnb_device_exchanged) {
        return;
    }
    [self _exchange];
}
@end
