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
    
    // close button ...
    static int closeButtonImageSize = 20.f;
    static int closeButtonImageTop  = 25.f;
    static int closeButtonImageLeft = 14.f;
    static int closeButtonSize      = 44.f;
    
    UIImageView *closeButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close"]];
    [closeButtonImage setTintColor:[UIColor whiteColor]];
    [self addSubviewAutoLayout:closeButtonImage];
    [closeButtonImage setHeightConstant:closeButtonImageSize];
    [closeButtonImage setWidthConstant:closeButtonImageSize];
    [closeButtonImage snapTopConstant:closeButtonImageTop];
    [closeButtonImage snapLeftConstant:closeButtonImageLeft];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    closeButton.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    [closeButton addTarget:self action:@selector(closeButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubviewAutoLayout:closeButton];
    [closeButton setHeightConstant:closeButtonSize];
    [closeButton setWidthConstant:closeButtonSize];
    [closeButton snapTopConstant:closeButtonImageTop - (closeButtonSize - closeButtonImageSize) / 2.f];
    [closeButton snapLeftConstant:closeButtonImageLeft - (closeButtonSize - closeButtonImageSize) / 2.f];
}

- (void)closeButtonDidPress
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headerDidClose)]) {
        [self.delegate headerDidClose];
    }
}

@end
