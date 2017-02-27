//
//  ThemeManager.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject

+ (instancetype)instance;

- (void)configureProxies;

#pragma mark - colors

- (UIColor *)navBar;
- (UIColor *)navBar:(CGFloat)alpha;
- (UIColor *)navBarText;
- (UIColor *)background;
- (UIColor *)text;
- (UIColor *)cardText;

#pragma mark - fonts

- (UIFont *)semiBoldFontWithSize:(CGFloat)size;
- (UIFont *)boldFontWithSize:(CGFloat)size;
- (UIFont *)regularFontWithSize:(CGFloat)size;
- (UIFont *)lightFontWithSize:(CGFloat)size;
- (UIFont *)mediumFontWithSize:(CGFloat)size;

@end
