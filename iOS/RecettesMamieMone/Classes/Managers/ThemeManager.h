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
- (UIColor *)backgroundClickabke;
- (UIColor *)text;
- (UIColor *)metaText;
- (UIColor *)cardText;
- (UIColor *)cardBackground;
- (UIColor *)line;

#pragma mark - fonts

//- (UIFont *)semiBoldFontWithSize:(CGFloat)size;
//- (UIFont *)boldFontWithSize:(CGFloat)size;
//- (UIFont *)regularFontWithSize:(CGFloat)size;
//- (UIFont *)lightFontWithSize:(CGFloat)size;
//- (UIFont *)mediumFontWithSize:(CGFloat)size;


- (UIFont *)openSansRegularFontWithSize:(CGFloat)size;
- (UIFont *)openSansBoldFontWithSize:(CGFloat)size;
- (UIFont *)merriweatherFontWithSize:(CGFloat)size;

@end
