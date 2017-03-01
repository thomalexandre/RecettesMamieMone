//
//  ThemeManager.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "ThemeManager.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation ThemeManager

+ (instancetype)instance
{
    static ThemeManager *_instance = nil;
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
        [self configureProxies];
    }
    return self;
}

- (void)printListOfFonts
{
    for (NSString* family in [UIFont familyNames])
    {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
        {
            NSLog(@"  %@", name);
        }
    }
}

//// Components proxies

- (void)configureProxies
{
    [self configureNavigationBar];
}

- (void)configureNavigationBar
{
    // http://www.appcoda.com/customize-navigation-status-bar-ios-7/
    
    [[UINavigationBar appearance] setBarTintColor:[self navBar]];
    [[UINavigationBar appearance] setTintColor:[self navBarText]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [self navBarText],
                                                            NSFontAttributeName: [self mediumFontWithSize:14]}];
    
}

#pragma mark - colors

/// palette https://coolors.co/870055-d10068-6f3d96-d07fff-050505

- (UIColor *)frenchPlum
{
    return UIColorFromRGB(0xD10068);
}

- (UIColor *)rubineRed
{
    return UIColorFromRGB(0xD10068);
}

- (UIColor *)purpleHeart
{
    return UIColorFromRGB(0x6F3D96);
}

- (UIColor *)heliotrope
{
    return UIColorFromRGB(0xD07FFF);
}

- (UIColor *)whiteSmoke
{
    return UIColorFromRGB(0xF7F7F7);
}

- (UIColor *)richBlack
{
    return UIColorFromRGB(0x050505);
}

/// Colors for ui elements

- (UIColor *)navBar
{
    return [self rubineRed];
}

- (UIColor *)navBar:(CGFloat)alpha
{
    return [[self navBar] colorWithAlphaComponent:alpha];
}

- (UIColor *)navBarText
{
    return [self whiteSmoke];
}

- (UIColor *)background
{
    return [self whiteSmoke];
}

- (UIColor *)text
{
    return [self richBlack];
}

- (UIColor *)metaText
{
    return [self rubineRed];
}

- (UIColor *)cardText
{
    return [self whiteSmoke];
}

- (UIColor *)line
{
    return [UIColorFromRGB(0xF0F0F0) colorWithAlphaComponent:0.8];
}

#pragma mark - fonts

- (UIFont *)semiBoldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SFUIText-Semibold" size:size];
}

- (UIFont *)boldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SFUIText-Bold" size:size];
}

- (UIFont *)regularFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SFUIText-Regular" size:size];
}

- (UIFont *)lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SFUIText-Light" size:size];
}

- (UIFont *)mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"SFUIText-Medium" size:size];
}

@end
