//
//  ColorTheme.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 1/4/18.
//  Copyright © 2018 MBC. All rights reserved.
//

#import "ColorTheme.h"
#import "UIColor+Utils.h"

@interface ColorTheme()

@property (nonatomic, strong) NSDictionary <NSString *, UIColor *> * colors;

@end

@implementation ColorTheme

- (instancetype)init
{
    self = [super init];
    if(self) {
        [self configureColors];
    }
    return self;
}

- (void)configureColors
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:UIColorFromRGB(0xD81B60) forKey:@"primary"];
    [dic setObject:UIColorFromRGB(0xD81B60) forKey:@"secondary"];
    [dic setObject:UIColorFromRGB(0x979797) forKey:@"accent"];     
    [dic setObject:UIColorFromRGB(0xF7F7F7) forKey:@"background"];
    [dic setObject:UIColorFromRGB(0x050505) forKey:@"text"];
    [dic setObject:UIColorFromRGB(0xF7F7F7) forKey:@"uitext"];
    [dic setObject:[UIColorFromRGB(0xF0F0F0) colorWithAlphaComponent:0.8] forKey:@"ui"];
    [dic setObject:[[UIColorFromRGB(0xF0F0F0) colorWithAlphaComponent:0.8] colorWithAlphaComponent:0.4] forKey:@"uilight"];
    [dic setObject:UIColorFromRGB(0xD81B60) forKey:@"error"];
    [dic setObject:UIColorFromRGB(0xD81B60) forKey:@"warning"];
    
    self.colors = [dic copy];
}

- (UIColor *)primary
{
    return self.colors[@"primary"];
}

- (UIColor *)secondary
{
    return self.colors[@"secondary"];
}

- (UIColor *)accent
{
    return self.colors[@"accent"];
}

- (UIColor *)background
{
    return self.colors[@"background"];
}

- (UIColor *)text
{
    return self.colors[@"text"];
}

- (UIColor *)uitext
{
    return self.colors[@"uitext"];
}

- (UIColor *)ui
{
    return self.colors[@"ui"];
}

- (UIColor *)uilight
{
    return self.colors[@"uilight"];
}

- (UIColor *)error
{
    return self.colors[@"error"];
}

- (UIColor *)warning
{
    return self.colors[@"warning"];
}

@end
