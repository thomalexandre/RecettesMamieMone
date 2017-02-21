//
//  ConfigurationManager.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "ConfigurationManager.h"
#import <UIKit/UIKit.h>
@import FirebaseRemoteConfig;

@interface ConfigurationManager ()

@property (nonatomic, strong) FIRRemoteConfig *remoteConfig;

@end

@implementation ConfigurationManager

+ (instancetype)instance
{
    static ConfigurationManager *_instance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _instance = [[self alloc] init];
                  });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        self.remoteConfig = [FIRRemoteConfig remoteConfig];
        
#warning TO remove in production
        FIRRemoteConfigSettings *remoteConfigSettings = [[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:YES];
        self.remoteConfig.configSettings = remoteConfigSettings;
        
        [self fetchConfiguration];
    }
    return self;
}

- (void)fetchConfiguration
{
    // cacheExpirationSeconds is set to cacheExpiration here, indicating that any previously
    // fetched and cached config would be considered expired because it would have been fetched
    // more than cacheExpiration seconds ago. Thus the next fetch would go to the server unless
    // throttling is in progress. The default expiration duration is 43200 (12 hours).
    
    NSTimeInterval expirationDuration = 43200;// (12 hours)
    
    [self.remoteConfig fetchWithExpirationDuration:expirationDuration completionHandler:^(FIRRemoteConfigFetchStatus status, NSError *error) {
        if (status == FIRRemoteConfigFetchStatusSuccess) {
            NSLog(@"Config fetched!");
            [self.remoteConfig activateFetched];
        } else {
            NSLog(@"Config not fetched");
            NSLog(@"Error %@", error.localizedDescription);
        }
    }];
}

#pragma mark persistent setting (stored in NSUserDefault)

- (BOOL)setPersistentSetting:(id)setting forKey:(NSString *)key
{
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    [cache setObject:setting forKey:key];
    return [cache synchronize];
}

- (id)persistentSettingForKey:(NSString *)key
{
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    return [cache objectForKey:key];
}

- (id)persistentSettingForKey:(NSString *)key withDefault:(id)defaultSetting
{
    id res = [self persistentSettingForKey:key];
    return res ? res : defaultSetting;
}

- (BOOL)removePersistentSettingForKey:(NSString *)key
{
    NSUserDefaults *cache = [NSUserDefaults standardUserDefaults];
    [cache removeObjectForKey:key];
    return [cache synchronize];
}

#pragma mark - Device

+ (BOOL)isIpad
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)isIphone
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

@end
