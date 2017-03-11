//
//  ReceipeCollectionViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/21/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "ReceipeCollectionViewCell.h"
#import "UIView+Layout.h"
#import "StorageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Utils.h"
#import "ThemeManager.h"
#import "GradientView.h"

#define kTextHeight 50

@interface ReceipeCollectionViewCell ()

@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UILabel      *titleLabel;
@property (nonatomic, strong) UIView       *gradient;
//@property (nonatomic, strong) UIImage      *placeholder;

@end

@implementation ReceipeCollectionViewCell

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
    // view...
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.contentView.layer.cornerRadius  = 4.0f;
    self.contentView.layer.borderWidth   = 1.0f;
    self.contentView.layer.borderColor   = [UIColor clearColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
    self.layer.shadowColor   = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset  = CGSizeMake(0, 2.0f);
    self.layer.shadowRadius  = 2.0f;
    self.layer.shadowOpacity = 1.0f;
    self.layer.masksToBounds = NO;
    
    // image....
//    self.placeholder = [UIImage imageNamed:@"placeholder"];
    self.imageView = [[UIImageView alloc] initWithImage:nil/*self.placeholder*/];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [[ThemeManager instance] cardBackground];
    self.imageView.clipsToBounds = YES;
    [self.contentView addSubviewAutoLayout:self.imageView];
    [self.imageView snap];
    
    // gradient...
    self.gradient = [GradientView new];
//    self.gradient.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self.contentView addSubviewAutoLayout:self.gradient];
    [self.gradient snapBottom];
    [self.gradient snapLeft];
    [self.gradient snapRight];
    [self.gradient setHeightConstant:kTextHeight+20];
    
    // text ...
    self.titleLabel           = [UILabel new];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = [[ThemeManager instance] cardText];
    self.titleLabel.font      = [[ThemeManager instance] openSansRegularFontWithSize:15];
    [self.contentView addSubviewAutoLayout:self.titleLabel];
    [self.titleLabel snapBottom];
    [self.titleLabel snapLeftConstant:10];
    [self.titleLabel snapRightConstant:10];
    [self.titleLabel setHeightConstant:kTextHeight];
}

- (void)prepareForReuse
{
    self.imageView.image = nil;//self.placeholder;
    self.titleLabel.text = nil;
}

- (void)setup:(Recipe *)recipe
{
    self.titleLabel.text = recipe.title;
    [[StorageManager instance] setImage:self.imageView path:[recipe thumbnail]];
}

@end
