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

#pragma mark - colors

- (UIColor *)background
{
    return UIColorFromRGB(0xF6F6F6);
}

- (UIColor *)text
{
    return UIColorFromRGB(0x333333);
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
