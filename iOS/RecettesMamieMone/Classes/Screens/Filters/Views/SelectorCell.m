//
//  SelectorCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/4/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "SelectorCell.h"
#import "UIView+Layout.h"
#import "UIImage+Utils.h"
#import "UIView+Utils.h"
#import "ATKApp.h"

@interface SelectorCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;

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
    self.contentView.layer.borderColor = [COLOR accent].CGColor;
    self.contentView.layer.borderWidth = 0.5f;
    
    self.imageView = [[UIImageView alloc] initWithImage:nil/*self.placeholder*/];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubviewAutoLayout:self.imageView];
    [self.imageView snapTop];
    [self.imageView snapLeft];
    [self.imageView snapRight];
    self.imageHeightConstraint = [self.imageView setHeightConstant:63.f];
    
    self.typeLabel = [UILabel new];
    self.typeLabel.textColor = [COLOR accent];
    self.typeLabel.font = [FONT fontWithSize:12 withWeight:ATKFontWeightBold];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubviewAutoLayout:self.typeLabel];
    [self.typeLabel snapBottomConstant:10];
    [self.typeLabel snapLeft];
    [self.typeLabel snapRight];
    [self.typeLabel setHeightConstant:17];
    [self.typeLabel snapTopToBottom:0 relativeToView:self.imageView];
}

- (void)setupWithRecipeType:(RecipeType *)recipeType
{
    self.imageView.image = [[UIImage imageNamed:recipeType.image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.typeLabel.text = recipeType.name;
    self.imageHeightConstraint.active = YES;
    
    [self updateSelected:recipeType.selected];
}

- (void)setupWithHardness:(Hardness *)hardness
{
    self.imageView.image = nil;
    self.typeLabel .text = hardness.name;
    self.imageHeightConstraint.active = NO;
    
    [self updateSelected:hardness.selected];
}

- (void)updateSelected:(BOOL)selected
{
    if(selected) {
        self.contentView.backgroundColor = [COLOR ui];
        self.typeLabel.textColor = [COLOR text];
        [self.imageView setTintColor:[COLOR primary]];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.typeLabel.textColor = [COLOR accent];
        [self.imageView setTintColor:[COLOR accent]];
    }
}

@end
