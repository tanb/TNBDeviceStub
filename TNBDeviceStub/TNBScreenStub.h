//
//  TNBScreenStub.h
//  TNBDeviceStub
//
//  Created by tanB on 3/31/14.
//  Copyright (c) 2014 tanB. All rights reserved.
//

@class UIWindow, UIScreenMode, NSMutableArray, NSDictionary, NSArray, UIScreen;

@interface TNBScreenStub : NSObject

@property(nonatomic) CGRect  bounds; // Bounds of entire screen in points
@property(nonatomic) CGRect  applicationFrame; // Frame of application screen area in points (i.e. entire screen minus status bar if visible)
@property(nonatomic) CGFloat scale NS_AVAILABLE_IOS(4_0);
@property(nonatomic, copy) NSArray *availableModes NS_AVAILABLE_IOS(3_2); // The list of modes that this screen supports
@property(nonatomic, retain) UIScreenMode *preferredMode NS_AVAILABLE_IOS(4_3); // Preferred mode of this screen. Choosing this mode will likely produce the best results
@property(nonatomic) UIScreenMode *currentMode NS_AVAILABLE_IOS(3_2); // Current mode of this screen
@property(nonatomic) UIScreenOverscanCompensation overscanCompensation NS_AVAILABLE_IOS(5_0); // Default is UIScreenOverscanCompensationScale. Determines how the screen behaves if the connected display is overscanning
@property(nonatomic,retain) UIScreen *mirroredScreen NS_AVAILABLE_IOS(4_3); // The screen being mirrored by the receiver. nil if mirroring is disabled or unsupported. Moving a UIWindow to this screen will disable mirroring
@property(nonatomic) CGFloat brightness NS_AVAILABLE_IOS(5_0); // 0 .. 1.0, where 1.0 is maximum brightness. Only supported by main screen.
@property(nonatomic) BOOL wantsSoftwareDimming NS_AVAILABLE_IOS(5_0); // Default is NO. If YES, brightness levels lower than that of which the hardware is capable are emulated in software, if neccessary. Having enabled may entail performance cost.

+ (NSArray *)screens NS_AVAILABLE_IOS(3_2); // all screens currently attached to the device
+ (id)mainScreen;      // the device's internal screen
- (CADisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)sel NS_AVAILABLE_IOS(4_0);

// UIScreen (UISnapshotting)
// Please see snapshotViewAfterScreenUpdates: in UIView.h for some important details on the behavior of this method when called from layoutSubviews.
- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates NS_AVAILABLE_IOS(7_0);
@end

@interface TNBScreenStub (TNBDeviceStubExchange)
+ (void)replace;
+ (void)restore;

- (void)replace;
- (void)restore;
@end
