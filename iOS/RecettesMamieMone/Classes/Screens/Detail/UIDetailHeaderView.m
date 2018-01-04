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
#import "ATKApp.h"

@interface UIDetailHeaderView ()

@property (nonatomic, strong) GradientView *gradient;
@property (nonatomic, strong) UIView       *barView;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIImageView  *borderImageView;

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
    self.barView.backgroundColor = [COLOR primary];
    [self addSubviewAutoLayout:self.barView];
    [self.barView snap];
    self.barView.hidden = YES;
    
    // close button ...
    static int closeButtonImageSize = 18.f;
    static int closeButtonImageLeft = 17.f;
    static int closeButtonSize      = 44.f;
    
    UIImageView *closeButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-close"]];
    [closeButtonImage setTintColor:[UIColor whiteColor]];
    [self addSubviewAutoLayout:closeButtonImage];
    [closeButtonImage setHeightConstant:closeButtonImageSize];
    [closeButtonImage setWidthConstant:closeButtonImageSize];
    if ([SETTING isIphoneX]) {
        [closeButtonImage snapTopConstant:12+44];
    } else {
        [closeButtonImage snapTopConstant:12+20];
    }
    
    [closeButtonImage snapLeftConstant:closeButtonImageLeft];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubviewAutoLayout:closeButton];
    [closeButton setHeightConstant:closeButtonSize];
    [closeButton setWidthConstant:closeButtonSize];
    if ([SETTING isIphoneX]) {
        [closeButton snapTopConstant:12+44 - (closeButtonSize - closeButtonImageSize) / 2.f];
    } else {
        [closeButton snapTopConstant:12+20 - (closeButtonSize - closeButtonImageSize) / 2.f];
    }
    
    [closeButton snapLeftConstant:closeButtonImageLeft - (closeButtonSize - closeButtonImageSize) / 2.f];
    
    // title ...
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [FONT fontWithSize:15 withWeight:ATKFontWeightBold];
    self.titleLabel.textColor = [COLOR uitext];
    [self addSubviewAutoLayout:self.titleLabel];
    
     if (@available(iOS 11, *)) {
         [self.titleLabel snapTopSafe];
     } else {
         [self.titleLabel snapTopConstant:20];
     }
    
    [self.titleLabel snapBottomConstant:kBorderDentelHeight];
    [self.titleLabel centerX];
    self.titleLabel.hidden = YES;
    
    // border ...
    self.borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hero-border-bottom"]];
    self.borderImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.borderImageView.clipsToBounds = YES;
    [self addSubviewAutoLayout:self.borderImageView];
    [self.borderImageView snapBottom];
    [self.borderImageView snapLeft];
    [self.borderImageView snapRight];
    [self.borderImageView setHeightConstant:kBorderDentelHeight];
    self.borderImageView.hidden = YES;
}

- (void)closeButtonDidPress
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(headerDidClose)]) {
        [self.delegate headerDidClose];
    }
}

- (void)showTopBar:(BOOL)showBar showText:(BOOL)showText recipe:(Recipe *)recipe
{
    self.gradient.hidden        = showBar;
    self.barView.hidden         = !showBar;
    self.borderImageView.hidden = !showBar;
    self.titleLabel.hidden      = !showText;
    self.titleLabel.text        = recipe.title;
}

- (void)updateGradientAlpha:(CGFloat)alpha
{
    self.gradient.alpha = alpha;
}


- (void)makeDisappear
{
    if(self.gradient.hidden) {
        self.gradient.alpha = 0;
        self.gradient.hidden = NO;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.barView.alpha = 0;
        self.titleLabel.alpha = 0;
        self.borderImageView.alpha = 0;
        self.gradient.alpha = 1;
    } completion:^(BOOL finished) {
        self.barView.alpha = 1;
        self.barView.hidden = YES;
        self.titleLabel.alpha = 1;
        self.titleLabel.hidden = YES;
        self.borderImageView.alpha = 1;
        self.borderImageView.hidden = YES;
    }];
}

@end
