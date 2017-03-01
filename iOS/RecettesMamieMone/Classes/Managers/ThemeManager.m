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

/// palette https://coolors.co/e63946-f1faee-2c3037-457b9d-1d3557

- (UIColor *)spaceCadet
{
    return UIColorFromRGB(0x1D3557);
}

- (UIColor *)queenBlue
{
    return UIColorFromRGB(0x457B9D);
}

- (UIColor *)honeydew
{
    return UIColorFromRGB(0xF1FAEE);
}

- (UIColor *)desire
{
    return UIColorFromRGB(0xE63946);
}

- (UIColor *)ghostWhite
{
    return UIColorFromRGB(0xF8F9FA);
}

- (UIColor *)gunMetal
{
    return UIColorFromRGB(0x2C3037);
}

/// Colors for ui elements

- (UIColor *)navBar
{
    return [self spaceCadet];
//    return UIColorFromRGB(0xE8985E);
}

- (UIColor *)navBar:(CGFloat)alpha
{
    return [[self navBar] colorWithAlphaComponent:alpha];
}

- (UIColor *)navBarText
{
    return [self honeydew];
}

- (UIColor *)background
{
    return [self ghostWhite];
}

- (UIColor *)text
{
    return [self gunMetal];
}

- (UIColor *)cardText
{
    return [self ghostWhite];
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
