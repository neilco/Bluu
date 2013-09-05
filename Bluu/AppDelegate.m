//
//  VNAppDelegate.m
//  BluetoothExternalDaemon
//
//  Created by Neil on 27/03/2013.
//  Copyright (c) 2013 Neil Cowburn. All rights reserved.
//
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "NCPreferences.h"
#include <sys/sysctl.h>

NSString *const kDisplayNotifications = @"displayNotifications";
NSString *const kBTExtDAppID = @"com.neilcowburn.btextd";
NSString *const kScreenCount = @"screenCount";

@interface AppDelegate () <NSUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (void)showNotification:(BOOL)bluetoothIsOn
{
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    center.delegate = self;
    
    NSUserNotification *note = [NSUserNotification new];
    note.title = @"Bluu";
    note.subtitle = [NSString stringWithFormat:@"Bluetooth has been turned %@", bluetoothIsOn ? @"on" : @"off"];
    
    [center deliverNotification:note];
}

- (void)toggleBluetooth
{
    [NCPreferences setAppID:kBTExtDAppID];
    BOOL showNotification = [[NCPreferences sharedPreferences] boolForKey:kDisplayNotifications];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger lastScreenCount = (NSUInteger)[defaults integerForKey:kScreenCount];
    
    NSArray *screens = [NSScreen screens];
    if (screens.count != lastScreenCount) {
        for (NSScreen *screen in screens) {
            CGDirectDisplayID screenID = [[[screen deviceDescription] objectForKey:@"NSScreenNumber"] unsignedIntValue];
            if (screens.count == 1 && CGDisplayIsBuiltin(screenID)) {
                if (IOBluetoothPreferenceGetControllerPowerState() == 1) {
                    IOBluetoothPreferenceSetControllerPowerState(0); // Turn BT off
                    if (showNotification) {
                        [self showNotification:NO];
                    }
                }
                break;
            } else if (screens.count >= 1 && !CGDisplayIsBuiltin(screenID)) { // First external display
                if (IOBluetoothPreferenceGetControllerPowerState() == 0) {
                    IOBluetoothPreferenceSetControllerPowerState(1); // Turn BT on
                    if (showNotification) {
                        [self showNotification:YES];
                    }
                }
                break;
            }
        }
        
        [defaults setInteger:screens.count forKey:kScreenCount];
        [defaults synchronize];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:@{ kScreenCount: @1 }];
    [defaults synchronize];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    [self toggleBluetooth];
}

- (void)applicationDidChangeScreenParameters:(NSNotification *)notification
{
    [self toggleBluetooth];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification;
{
    return YES;
}

@end
