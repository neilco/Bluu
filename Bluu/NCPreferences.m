//
//  NCPreferences.m
//  Bluetooth Switch
//
//  Created by Neil on 27/04/2013.
//  Copyright (c) 2013 Neil Cowburn. All rights reserved.
//

#import "NCPreferences.h"

@interface NCPreferences () {
    NSString *_appID;
}

- (void)setAppID:(NSString *)appID;
- (void)checkAppID;

@end

@implementation NCPreferences

#pragma mark - Lifecycle Management

+ (id)sharedPreferences
{
    static NCPreferences *_sharedPrefs = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedPrefs = [NCPreferences new];
    });
    
    return _sharedPrefs;
}

+ (void)setAppID:(NSString *)appID
{
    [[NCPreferences sharedPreferences] setAppID:appID];
}

// --------------------------------------------------------------------------------------------------------------------------

#pragma mark - Boolean Preferences

- (BOOL)boolForKey:(NSString *)key
{
    [self checkAppID];
    
    BOOL returnValue = YES;
    
    CFPropertyListRef value = CFPreferencesCopyAppValue((__bridge CFStringRef)key, (__bridge CFStringRef)_appID);
    if (value && CFGetTypeID(value) == CFBooleanGetTypeID()) {
        returnValue = CFBooleanGetValue(value);
    }
    
    if (value) { CFRelease(value); }
    
    return returnValue;
}

- (void)setBool:(BOOL)value forKey:(NSString *)key
{
    [self checkAppID];
    
    CFBooleanRef newValue = (value == YES) ? kCFBooleanTrue : kCFBooleanFalse;
    CFPreferencesSetAppValue((__bridge CFStringRef)key, newValue, (__bridge CFStringRef)_appID);
    CFPreferencesAppSynchronize((__bridge CFStringRef)_appID);
}

// --------------------------------------------------------------------------------------------------------------------------

#pragma mark - Private Methods

- (void)setAppID:(NSString *)appID
{
    _appID = appID;
}

- (void)checkAppID
{
    if (_appID == nil || _appID.length == 0) {
        NSAssert(false, @"You must call [NCPreferences setAppID:] before attempting to read or write preferences.");
    }
}

@end
