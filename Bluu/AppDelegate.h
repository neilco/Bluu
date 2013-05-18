//
//  VNAppDelegate.h
//  BluetoothExternalDaemon
//
//  Created by Neil on 27/03/2013.
//  Copyright (c) 2013 Vividnoise. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@end

void IOBluetoothPreferenceSetControllerPowerState(int powerstate);
int IOBluetoothPreferenceGetControllerPowerState();