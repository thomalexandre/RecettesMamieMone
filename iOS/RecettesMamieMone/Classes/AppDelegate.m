//
//  AppDelegate.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ColorTheme.h"
#import "FontTheme.h"
#import "UIAppearance.h"

@import Fabric;
@import Crashlytics;
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [FIRApp configure];
    [[Fabric sharedSDK] setDebug: YES];
    [Fabric with:@[[Crashlytics class]]];
    
    
    // setup application
    [ATKApp instance].uiConfig.colorTheme   = [ColorTheme new];
    [ATKApp instance].uiConfig.fontTheme    = [FontTheme new];
//    [ATKApp instance].uiConfig.systemTheme  = [ATKDefaultSystemTheme new];
    [ATKApp instance].uiConfig.appearance   = [UIAppearance new];
//    [ATKApp instance].settings              = [SBSettings new];
    [[ATKApp instance].uiConfig configureApplication];
    
    [FIRDatabase database].persistenceEnabled = YES;
    
    [self setupRootViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if([SETTING isIpad]) {
        return UIInterfaceOrientationMaskAll;
    } else if ([SETTING isIphone]) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return 0;
}

#pragma mark - Setup

- (void)setupRootViewController
{   
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[RootViewController instance]];
    [self.window makeKeyAndVisible];
}


@end
