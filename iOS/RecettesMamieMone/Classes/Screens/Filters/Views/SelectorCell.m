//
//  SelectorCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/4/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "SelectorCell.h"
#import "UIView+Layout.h"
#import "ThemeManager.h"
#import "UIImage+Utils.h"

@interface SelectorCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *typeLabel;

@end

@implementation SelectorCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
//    self.contentView.backgroundColor = [[ThemeManager instance] cardBackground];
    self.contentView.layer.borderColor = [[ThemeManager instance] border].CGColor;
    self.contentView.layer.borderWidth = 0.5f;
    
    self.imageView = [[UIImageView alloc] initWithImage:nil/*self.placeholder*/];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubviewAutoLayout:self.imageView];
    [self.imageView snapTop];
    [self.imageView snapLeft];
    [self.imageView snapRight];
    [self.imageView setHeightConstant:63];
    
    self.typeLabel = [UILabel new];
    self.typeLabel.textColor = [[ThemeManager instance] border];
    self.typeLabel.font = [[ThemeManager instance] openSansBoldFontWithSize:12];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubviewAutoLayout:self.typeLabel];
    [self.typeLabel snapBottomConstant:10];
    [self.typeLabel snapLeft];
    [self.typeLabel snapRight];
    [self.typeLabel setHeightConstant:17];
    [self.typeLabel snapTopToBottom:0 relativeToView:self.imageView];
}

- (void)setup:(RecipeType *)recipeType
{
    self.imageView.image = [[UIImage imageNamed:recipeType.image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.imageView setTintColor:[[ThemeManager instance] border]];
    self.typeLabel.text = recipeType.name;
}

- (void)setSelected:(BOOL)selected
{
    if(selected) {
        self.contentView.backgroundColor = [[ThemeManager instance] cardBackground];
        self.typeLabel.textColor = [[ThemeManager instance] text];
        [self.imageView setTintColor:[[ThemeManager instance] navBar]];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.typeLabel.textColor = [[ThemeManager instance] border];
        [self.imageView setTintColor:[[ThemeManager instance] border]];
    }
}

@end
