//
//  TNBDeviceStubTest.m
//  TNBDeviceStubTest
//
//  Created by tanB on 3/31/14.
//  Copyright (c) 2014 tanB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TNBDeviceStub.h"
#import "TNBScreenStub.h"

@interface TNBDeviceStubTest : XCTestCase

@end

@implementation TNBDeviceStubTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [TNBDeviceStub restore];
    XCTAssertEqual([[UIDevice currentDevice] class], [UIDevice class], @"couldn't restore UIDevice's method");
    [super tearDown];
}

/*
 The "replace" exchanges the implementation of "currentDevice" with UIDevice.
 Check updated instance values correctly.
 */
- (void)test_replaceIntanceMethod
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    stubDevice.name = @"stub";
    stubDevice.model = @"stub";
    stubDevice.localizedModel = @"stub";
    stubDevice.systemName = @"stub";
    stubDevice.systemVersion = @"stub";
    stubDevice.orientation = 1000;
    stubDevice.identifierForVendor = [[NSUUID alloc] initWithUUIDString:@"E621E1F8-C36C-495A-93FC-0C247A3E6E5F"];
    stubDevice.generatesDeviceOrientationNotifications = YES;
    stubDevice.batteryMonitoringEnabled = YES;
    stubDevice.batteryState = 1000;
    stubDevice.batteryLevel = 1.0;
    stubDevice.proximityMonitoringEnabled = YES;
    stubDevice.proximityState = YES;
    stubDevice.multitaskingSupported = YES;
    stubDevice.userInterfaceIdiom = 1000;
    
    [stubDevice replace];
    
    UIDevice *device = [UIDevice currentDevice];
    
    XCTAssertEqualObjects(device, stubDevice, @"couldn't replace UIDevice's method");
    
    XCTAssertEqualObjects(device.name, @"stub", @"device name unchanged");
    XCTAssertEqualObjects(device.model, @"stub", @"device model unchanged");
    XCTAssertEqualObjects(device.localizedModel, @"stub", @"device localizedModel unchanged");
    XCTAssertEqualObjects(device.systemName, @"stub", @"device systemName unchanged");
    XCTAssertEqualObjects(device.systemVersion, @"stub", @"device systemVersion unchanged");
    XCTAssertEqual(device.orientation, 1000, @"device orientation unchanged");
    XCTAssertEqualObjects(device.identifierForVendor.UUIDString, @"E621E1F8-C36C-495A-93FC-0C247A3E6E5F", @"device identifierForVendor unchanged");
    XCTAssertEqual(device.generatesDeviceOrientationNotifications, YES, @"device generatesDeviceOrientationNotifications unchanged");
    XCTAssertEqual(device.batteryMonitoringEnabled, YES, @"device batteryMonitoringEnabled unchanged");
    XCTAssertEqual(device.batteryState, 1000, @"device batteryState unchanged");
    XCTAssertEqual(device.batteryLevel, 1.0, @"device batteryLevel unchanged");
    XCTAssertEqual(device.proximityMonitoringEnabled, YES, @"device proximityMonitoringEnabled unchanged");
    XCTAssertEqual(device.proximityState, YES, @"device proximityState unchanged");
    XCTAssertEqual(device.multitaskingSupported, YES, @"device multitaskingSupported unchanged");
    XCTAssertEqual(device.userInterfaceIdiom, 1000, @"device userInterfaceIdiom unchanged");
}

/*
 The "replace" exchanges the implementation of "currentDevice" with UIDevice.
 Even though the "replace" is invoked twice, UIDevice's currentDevice is still replaced with TNBDeviceStub's implementation.
 */
- (void)test_replaceInstanceMethodInvokeTwice
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace];
    [stubDevice replace];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqualObjects(device, stubDevice, @"couldn't replace UIDevice's method");
}

/*
 The "replace" exchanges the implementation of "currentDevice" with UIDevice.
 */
- (void)test_replaceClassMethod
{
    [TNBDeviceStub replace];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [TNBDeviceStub class], @"couldn't replace UIDevice's method");
}

/*
 The "replace" exchanges the implementation of "currentDevice" with UIDevice.
 Even though the "replace" is invoked twice, UIDevice's currentDevice is still replaced with TNBDeviceStub's implementation.
 */
- (void)test_replaceClassMethodInvokeTwice
{
    [TNBDeviceStub replace];
    [TNBDeviceStub replace];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [TNBDeviceStub class], @"couldn't replace UIDevice's method");
}

/*
 The "restore" exchanges the replaced implementations.
 */
- (void)test_restoreInstanceMethod
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace];
    [stubDevice restore];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [UIDevice class], @"couldn't restore UIDevice's method");
}

/*
 The "restore" exchanges the replaced implementations.
 Even though the "restore" is invoked twice, UIDevice's currentDevice is the original implementation.
 */
- (void)test_restoreInstanceMethodTwice
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace];
    [stubDevice restore];
    [stubDevice restore];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [UIDevice class], @"couldn't restore UIDevice's method");
}

/*
 The "restore" exchanges the replaced implementations.
 */
- (void)test_restoreClassMethod
{
    [TNBDeviceStub replace];
    [TNBDeviceStub restore];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [UIDevice class], @"couldn't restore UIDevice's method");
}

/*
 The "restore" exchanges the replaced implementations.
 Even though the "restore" is invoked twice, UIDevice's currentDevice is the original implementation.
 */
- (void)test_restoreClassMethodTwice
{
    [TNBDeviceStub replace];
    [TNBDeviceStub restore];
    [TNBDeviceStub restore];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [UIDevice class], @"couldn't restore UIDevice's method");
}

/*
 The "restore" exchanges the replaced implementations.
 Even though the "restore" is invoked without "replace", UIDevice's currentDevice is the original implementation.
 */
- (void)test_restoreInstanceMethodWithoutReplace
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice restore];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [UIDevice class], @"couldn't restore UIDevice's method");
}

/*
 The "restore" exchanges the replaced implementations.
 Even though the "restore" is invoked without "replace", UIDevice's currentDevice is the original implementation.
 */
- (void)test_restoreClassMethodWithoutReplace
{
    [TNBDeviceStub restore];
    
    UIDevice *device = [UIDevice currentDevice];
    XCTAssertEqual([device class], [UIDevice class], @"couldn't restore UIDevice's method");
}

- (void)test_replaceAndRestoreCombination1
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace]; // custom stub
    [stubDevice restore]; // restore original
    [stubDevice replace]; // custom stub
    XCTAssertEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't replace correctly");
}

- (void)test_replaceAndRestoreCombination2
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace]; // custom stub
    [stubDevice restore]; // restore original
    [TNBDeviceStub replace]; // default stub
    XCTAssertNotEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't restore correctly");
}

- (void)test_replaceAndRestoreCombination3
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace]; // custom stub
    [TNBDeviceStub restore]; // restore original
    [stubDevice replace]; // custom stub
    XCTAssertEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't replace correctly");
}

- (void)test_replaceAndRestoreCombination4
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace]; // custom stub
    [TNBDeviceStub restore]; // restore original
    [TNBDeviceStub replace]; // default stub
    XCTAssertNotEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't restore correctly");
}

- (void)test_replaceAndRestoreCombination5
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [TNBDeviceStub replace]; // default stub
    [TNBDeviceStub restore]; // restore original
    [stubDevice replace]; // custom stub
    XCTAssertEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't replace correctly");
}

- (void)test_replaceAndRestoreCombination6
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [TNBDeviceStub replace]; // default stub
    [stubDevice restore]; // restore original
    [stubDevice replace]; // custom stub
    XCTAssertEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't replace correctly");
}

- (void)test_replaceAndRestoreCombination7
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [stubDevice replace]; // custom stub
    [TNBDeviceStub replace]; // default stub
    XCTAssertNotEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't replace correctly");
}

- (void)test_replaceAndRestoreCombination8
{
    TNBDeviceStub *stubDevice = [TNBDeviceStub new];
    [TNBDeviceStub replace]; // default stub
    [stubDevice replace]; // custom stub
    XCTAssertEqualObjects([UIDevice currentDevice], stubDevice, @"couldn't replace correctly");
}


@end

@interface TNBScreenStubTest : XCTestCase

@end

@implementation TNBScreenStubTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [TNBScreenStub restore];
    XCTAssertEqual([[UIScreen mainScreen] class], [UIScreen class], @"couldn't restore UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [UIScreen class], @"couldn't restore UIScreen's method");
    }];

    [super tearDown];
}

- (void)test_replaceIntanceMethod
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    stubScreen.bounds = CGRectMake(0, 0, 0, -1);
    stubScreen.applicationFrame = CGRectMake(0, 0, 0, -1);
    stubScreen.scale = 3.0;
    stubScreen.availableModes = @[@"stub"];
    UIScreenMode *screenMode = [UIScreenMode new];
    stubScreen.preferredMode = screenMode;
    stubScreen.currentMode = screenMode;
    stubScreen.overscanCompensation = 1000;
    UIScreen *mirroredScreen = [UIScreen new];
    stubScreen.mirroredScreen = mirroredScreen;
    stubScreen.brightness = 1000;
    stubScreen.wantsSoftwareDimming = YES;
    
    [stubScreen replace];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqualObjects(screen, stubScreen, @"couldn't replace UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, stubScreen, @"couldn't replace UIScreen's method");
    }];
    
    XCTAssertEqual(screen.bounds.size.height, -1, @"screen bounds unchanged");
    XCTAssertEqual(screen.applicationFrame.size.height, -1, @"screen applicationFrame unchanged");
    XCTAssertEqual(screen.scale, 3.0, @"screen scale unchanged");
    XCTAssertEqualObjects(screen.availableModes[0], @"stub", @"screen availableModes unchanged");
    XCTAssertEqualObjects(screen.preferredMode, screenMode, @"screen preferredMode unchanged");
    XCTAssertEqualObjects(screen.currentMode, screenMode, @"screen currentMode unchanged");
    XCTAssertEqual(screen.overscanCompensation, 1000, @"screen overscanCompensation unchanged");
    XCTAssertEqualObjects(screen.mirroredScreen, mirroredScreen, @"screen mirroredScreen unchanged");
    XCTAssertEqual(screen.brightness, 1000, @"screen brightness unchanged");
    XCTAssertEqual(screen.wantsSoftwareDimming, YES, @"screen wantsSoftwareDimming unchanged");
}

- (void)test_replaceIntanceMethodInvokeTwice
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace];
    [stubScreen replace];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqualObjects(screen, stubScreen, @"couldn't replace UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual(obj, stubScreen, @"couldn't replace UIScreen's method");
    }];

}

- (void)test_replaceClassMethod
{
    [TNBScreenStub replace];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [TNBScreenStub class], @"couldn't replace UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [TNBScreenStub class], @"couldn't replace UIScreen's method");
    }];
}

- (void)test_replaceClassMethodInvokeTwice
{
    [TNBScreenStub replace];
    [TNBScreenStub replace];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [TNBScreenStub class], @"couldn't replace UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [TNBScreenStub class], @"couldn't replace UIScreen's method");
    }];
}

- (void)test_restoreInstanceMethod
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace];
    [stubScreen restore];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [UIScreen class], @"couldn't restore UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [UIScreen class], @"couldn't restore UIScreen's method");
    }];
}

- (void)test_restoreInstanceMethodInvokeTwice
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace];
    [stubScreen restore];
    [stubScreen restore];

    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [UIScreen class], @"couldn't restore UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [UIScreen class], @"couldn't restore UIScreen's method");
    }];
}

- (void)test_restoreClassMethod
{
    [TNBScreenStub replace];
    [TNBScreenStub restore];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [UIScreen class], @"couldn't restore UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [UIScreen class], @"couldn't restore UIScreen's method");
    }];
}

- (void)test_restoreClassMethodInvokeTwice
{
    [TNBScreenStub replace];
    [TNBScreenStub restore];
    [TNBScreenStub restore];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [UIScreen class], @"couldn't restore UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [UIScreen class], @"couldn't restore UIScreen's method");
    }];
}

- (void)test_restoreInstanceMethodWithoutReplace
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen restore];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [UIScreen class], @"couldn't restore UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [UIScreen class], @"couldn't restore UIScreen's method");
    }];
}

- (void)test_restoreClassMethodWithoutReplace
{
    [TNBScreenStub restore];
    
    UIScreen *screen = [UIScreen mainScreen];
    XCTAssertEqual([screen class], [UIScreen class], @"couldn't restore UIScreen's method");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqual([obj class], [UIScreen class], @"couldn't restore UIScreen's method");
    }];
}

- (void)test_replaceAndRestoreCombination1
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace]; // custom stub
    [stubScreen restore]; // restore original
    [stubScreen replace]; // custom stub
    XCTAssertEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't replace correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

- (void)test_replaceAndRestoreCombination2
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace]; // custom stub
    [stubScreen restore]; // restore original
    [TNBScreenStub replace]; // default stub
    XCTAssertNotEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't restore correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertNotEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

- (void)test_replaceAndRestoreCombination3
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace]; // custom stub
    [TNBScreenStub restore]; // restore original
    [stubScreen replace]; // custom stub
    XCTAssertEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't replace correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

- (void)test_replaceAndRestoreCombination4
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace]; // custom stub
    [TNBScreenStub restore]; // restore original
    [TNBScreenStub replace]; // default stub
    XCTAssertNotEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't restore correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertNotEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

- (void)test_replaceAndRestoreCombination5
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [TNBScreenStub replace]; // default stub
    [TNBScreenStub restore]; // restore original
    [stubScreen replace]; // custom stub
    XCTAssertEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't replace correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

- (void)test_replaceAndRestoreCombination6
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [TNBScreenStub replace]; // default stub
    [stubScreen restore]; // restore original
    [stubScreen replace]; // custom stub
    XCTAssertEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't replace correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

- (void)test_replaceAndRestoreCombination7
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [stubScreen replace]; // custom stub
    [TNBScreenStub replace]; // default stub
    XCTAssertNotEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't replace correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertNotEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

- (void)test_replaceAndRestoreCombination8
{
    TNBScreenStub *stubScreen = [TNBScreenStub new];
    [TNBScreenStub replace]; // default stub
    [stubScreen replace]; // custom stub
    XCTAssertEqualObjects([UIScreen mainScreen], stubScreen, @"couldn't replace correctly");
    [[UIScreen screens] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertEqualObjects(obj, stubScreen, @"couldn't replace correctly");
    }];
}

@end
