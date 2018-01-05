//
//  FontTheme.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 1/4/18.
//  Copyright © 2018 MBC. All rights reserved.
//

#import "FontTheme.h"

@implementation FontTheme

- (UIFont *)fontWithSize:(NSUInteger)size withWeight:(ATKFontWeight)weight;
{
    if(weight == ATKFontWeightText) {
        return [self merriweatherFontWithSize:size];
    }
    if(weight == ATKFontWeightBold) {
        return [self openSansBoldFontWithSize:size];
    }
    return [self openSansRegularFontWithSize:size];
}

- (UIFont *)openSansRegularFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"OpenSans" size:size];
}

- (UIFont *)openSansBoldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"OpenSans-Bold" size:size];
}

- (UIFont *)merriweatherFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Merriweather-Regular" size:size];
}

@end
