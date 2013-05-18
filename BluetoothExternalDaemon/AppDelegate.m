//
//  VNAppDelegate.m
//  BluetoothExternalDaemon
//
//  Created by Neil on 27/03/2013.
//  Copyright (c) 2013 Vividnoise. All rights reserved.
//
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "NCPreferences.h"
#include <sys/sysctl.h>

NSString *const kDisplayNotifications = @"displayNotifications";
NSString *const kBTExtDAppID = @"com.neilcowburn.btextd";

@interface AppDelegate () <NSUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (void)showNotification:(BOOL)bluetoothIsOn
{
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    center.delegate = self;
    
    NSUserNotification *note = [NSUserNotification new];
    note.title = @"Bluetooth Watcher Daemon";
    note.subtitle = [NSString stringWithFormat:@"Bluetooth has been turned %@", bluetoothIsOn ? @"on" : @"off"];
    
    [center deliverNotification:note];
}

- (void)toggleBluetooth
{
    [NCPreferences setAppID:kBTExtDAppID];
    BOOL showNotification = [[NCPreferences sharedPreferences] boolForKey:kDisplayNotifications];
    
    NSArray *screens = [NSScreen screens];
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
