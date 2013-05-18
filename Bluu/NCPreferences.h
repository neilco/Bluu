//
//  NCPreferences.h
//  Bluetooth Switch
//
//  Created by Neil on 27/04/2013.
//  Copyright (c) 2013 Neil Cowburn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NCPreferences : NSObject

+ (id)sharedPreferences;
+ (void)setAppID:(NSString *)appID;

- (BOOL)boolForKey:(NSString *)key;
- (void)setBool:(BOOL)value forKey:(NSString *)key;

@end
