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
#import "ThemeManager.h"

@interface UIDetailHeaderView ()

@property (nonatomic, strong) GradientView *gradient;
@property (nonatomic, strong) UIView       *barView;
@property (nonatomic, strong) UILabel      *titleLabel;

@end

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
    self.gradient = [[GradientView alloc] init:GradientDownTop];
    [self addSubviewAutoLayout:self.gradient];
    [self.gradient snap];
    
    self.barView = [UIView new];
    self.barView.backgroundColor = [[ThemeManager instance] navBar];
    [self addSubviewAutoLayout:self.barView];
    [self.barView snap];
    self.barView.hidden = YES;
    
    // close button ...
    static int closeButtonImageSize = 16.f;
    static int closeButtonImageTop  = 28.f;
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
    
    // title ...
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [[ThemeManager instance] mediumFontWithSize:15];
    self.titleLabel.textColor = [[ThemeManager instance] navBarText];
    [self addSubviewAutoLayout:self.titleLabel];
    [self.titleLabel snapTopConstant:10];
    [self.titleLabel snapBottom];
    [self.titleLabel centerX];
//    [self.titleLabel snapRightConstant:8];
//    [self.titleLabel snapLeftToRight:10 relativeToView:closeButton];
    self.titleLabel.hidden = YES;
}

- (void)closeButtonDidPress
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headerDidClose)]) {
        [self.delegate headerDidClose];
    }
}

- (void)showTopBar:(BOOL)showBar recipe:(Recipe *)recipe
{
    self.gradient.hidden = showBar;
    self.barView.hidden = !showBar;
    self.titleLabel.hidden = !showBar;
    self.titleLabel.text = recipe.title;
}

@end
