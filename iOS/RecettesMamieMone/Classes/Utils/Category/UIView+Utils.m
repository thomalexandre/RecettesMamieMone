//
//  UIView+Utils.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)roundedCorner:(CGFloat)radius
{
    self.layer.cornerRadius  = radius;
    self.layer.masksToBounds = YES;
}

@end
