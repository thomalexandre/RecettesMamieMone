//
//  UIDetailHeaderView.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "UIDetailHeaderView.h"
#import "GradientView.h"
#import "UIView+Layout.h"
#import "UIView+Utils.h"

@implementation UIDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    // gradient ...
    GradientView *gradient = [[GradientView alloc] init:GradientDownTop];
    [self addSubviewAutoLayout:gradient];
    [gradient snap];
    
    // close buttom ...
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTintColor:[UIColor whiteColor]];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubviewAutoLayout:closeButton];
    [closeButton setHeightConstant:18];
    [closeButton setWidthConstant:18];
    [closeButton snapTopConstant:26];
    [closeButton snapLeftConstant:15];
}

- (void)closeButtonDidPress
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headerDidClose)]) {
        [self.delegate headerDidClose];
    }
}

@end
