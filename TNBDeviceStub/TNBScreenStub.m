//
//  TNBScreenStub.m
//  TNBDeviceStub
//
//  Created by tanB on 3/31/14.
//  Copyright (c) 2014 tanB. All rights reserved.
//

#import "TNBScreenStub.h"
#import <objc/runtime.h>

@implementation TNBScreenStub
static TNBScreenStub *tnb_currentScreen;
static BOOL tnb_screen_exchanged;

+ (void)initialize
{
    tnb_screen_exchanged = NO;
    tnb_currentScreen = nil;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _bounds = CGRectZero;
    _applicationFrame = CGRectZero;
    _scale = 1.0;
    _availableModes = @[[UIScreenMode new]];
    _preferredMode = [UIScreenMode new];
    _currentMode = [UIScreenMode new];
    _overscanCompensation = UIScreenOverscanCompensationScale;
    _mirroredScreen = nil;
    _brightness = 0;
    _wantsSoftwareDimming = NO;
    
    return self;
}

+ (NSArray *)screens {
    @synchronized(self) {
        if(tnb_currentScreen == nil)
            tnb_currentScreen = [TNBScreenStub new];
    }
    
    return @[tnb_currentScreen];
}

+ (id)mainScreen {
    @synchronized(self) {
        if(tnb_currentScreen == nil)
            tnb_currentScreen = [TNBScreenStub new];
    }
    
    return tnb_currentScreen;
}

- (CADisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)sel {
    return nil;
}

- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates {
    return nil;
}

@end

@implementation TNBScreenStub (TNBDeviceStubExchange)
+ (void)_exchange
{
    Method origMethod = class_getClassMethod([UIScreen class], @selector(mainScreen));
    Method newMethod = class_getClassMethod([TNBScreenStub class], @selector(mainScreen));
    method_exchangeImplementations(origMethod, newMethod);
    
    origMethod = class_getClassMethod([UIScreen class], @selector(screens));
    newMethod = class_getClassMethod([TNBScreenStub class], @selector(screens));
    method_exchangeImplementations(origMethod, newMethod);
    
    tnb_screen_exchanged = !tnb_screen_exchanged;
}

+ (void)replace
{
    if (tnb_screen_exchanged) {
        return;
    }
    [TNBScreenStub _exchange];
}

+ (void)restore
{
    tnb_currentScreen = nil;
    if (!tnb_screen_exchanged) {
        return;
    }
    [TNBScreenStub _exchange];
}

- (void)_exchange
{
    Method origMethod = class_getClassMethod([UIScreen class], @selector(mainScreen));
    Method newMethod = class_getClassMethod([TNBScreenStub class], @selector(mainScreen));
    method_exchangeImplementations(origMethod, newMethod);
    
    origMethod = class_getClassMethod([UIScreen class], @selector(screens));
    newMethod = class_getClassMethod([TNBScreenStub class], @selector(screens));
    method_exchangeImplementations(origMethod, newMethod);
    
    tnb_screen_exchanged = !tnb_screen_exchanged;
}

- (void)replace
{
    tnb_currentScreen = self;
    if (tnb_screen_exchanged) {
        return;
    }
    [self _exchange];
}

- (void)restore
{
    tnb_currentScreen = nil;
    if (!tnb_screen_exchanged) {
        return;
    }
    [self _exchange];
}
@end