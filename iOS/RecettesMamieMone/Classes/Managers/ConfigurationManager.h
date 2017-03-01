//
//  ConfigurationManager.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigurationManager : NSObject

+ (instancetype)instance;

// fetch remote config
- (void)fetchConfiguration:(void (^)())completion;

#pragma mark persistent setting (stored in NSUserDefault)

/// Store a persistent setting for the given key.
/// Return YES if everything was fine
- (BOOL)setPersistentSetting:(id)setting forKey:(NSString *)key;

/// Ket the persistent setting for the given key.
- (id)persistentSettingForKey:(NSString *)key;

/// Ket the persistent setting for the given key. Returns the defaultSetting if nothing is found
- (id)persistentSettingForKey:(NSString *)key withDefault:(id)defaultSetting;

/// Remove the persistent setting for the given key.
- (BOOL)removePersistentSettingForKey:(NSString *)key;

/// return YES if the device is an ipad.
+ (BOOL)isIpad;

/// return YES if the device is an iphone.
+ (BOOL)isIphone;

/// Return YES if the device is a test device (taken from remote config)
- (BOOL)isTestDevice;

@end
