//
//  HeroImageTableViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "HeroImageTableViewCell.h"
#import "UIView+Layout.h"
#import "StorageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+Utils.h"
#import "ATKApp.h"

#define kHeroImageHeight   300.f
#define kHeroNavbarHeight  64.f

@interface HeroImageTableViewCell ()

@property (nonatomic, strong) UIView      *overView;
@property (nonatomic, strong) UIImageView *heroImageView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property (nonatomic, strong) UIButton *photoButton;

@end

@implementation HeroImageTableViewCell
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setupUI];
    }
    return self;
}
    
- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.masksToBounds = YES;
    
    // image....
    self.heroImageView = [UIImageView new];
    self.heroImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.heroImageView.clipsToBounds = YES;
    self.heroImageView.layer.masksToBounds = YES;
    [self.contentView addSubviewAutoLayout:self.heroImageView];
    self.topConstraint = [self.heroImageView snapTop];
    [self.heroImageView snapLeft];
    [self.heroImageView snapRight];
    [self.heroImageView snapBottom];
    self.heightConstraint = [self.heroImageView setHeightConstant:kHeroImageHeight];
    
    // over view ...
    self.overView = [UIView new];
    self.overView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [self.contentView addSubviewAutoLayout:self.overView];
    [self.overView snap];
    
    // border ...
    UIImageView *borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hero-border-bottom"]];
    borderImageView.contentMode = UIViewContentModeScaleAspectFill;
    borderImageView.clipsToBounds = YES;
    [self.contentView addSubviewAutoLayout:borderImageView];
    [borderImageView snapBottom];
    [borderImageView snapLeft];
    [borderImageView snapRight];
    [borderImageView setHeightConstant:10];

    /// photos buttons
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.photoButton setImage:[UIImage imageNamed:@"icon-camera"] forState:UIControlStateNormal];
    [self.photoButton addTarget:self action:@selector(cameraButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubviewAutoLayout:self.photoButton];
    [self.photoButton snapBottomConstant:12];
    [self.photoButton snapRightConstant:8];
    [self.photoButton setHeightConstant:40];
    [self.photoButton setWidthConstant:60];
    self.photoButton.titleLabel.font = [FONT fontWithSize:10 withWeight:ATKFontWeightBold];
    self.photoButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.photoButton setTitleEdgeInsets: UIEdgeInsetsMake(2,-45,0,0)];
    [self.photoButton setImageEdgeInsets: UIEdgeInsetsMake(0,25,0,0)];
}

- (void)setup:(Recipe *)recipe
{
    [[StorageManager instance] setImage:self.heroImageView path:[recipe thumbnail]];
    
    self.photoButton.hidden = [recipe.photos count] == 0;
    [self.photoButton setTitle:[NSString stringWithFormat:@"%ld", [recipe.photos count] ] forState:UIControlStateNormal];

//    [self layoutIfNeeded];
}
    
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.heroImageView.image = nil;
}

- (CGFloat)viewDidScroll:(CGFloat)scrollY
{
    self.topConstraint.constant    = scrollY > 0 ? scrollY/2 : scrollY;
    self.heightConstraint.constant = scrollY > 0 ? kHeroImageHeight-scrollY/2 : kHeroImageHeight + fabs(scrollY);
    
    //CGFloat alpha = scrollY > kHeroImageHeight / 3.f ? (kHeroImageHeight/3.f-(kHeroImageHeight-scrollY)) / (kHeroImageHeight/3.f) : 0;
    CGFloat alpha = scrollY > kHeroImageHeight / 3.f ? (scrollY - kHeroImageHeight / 3.0) / ((kHeroImageHeight - 74) - (kHeroImageHeight / 3.0)) : 0;
    self.overView.backgroundColor = [[COLOR primary] colorWithAlphaComponent:alpha];
    self.photoButton.alpha = 1.f - alpha * 10.;
    
   // NSLog(@"%f %f", scrollY, alpha);
    
    return alpha;
}

- (void)cameraButtonDidClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(photoButtonDidSelect)]) {
        [self.delegate photoButtonDidSelect];
    }
}


@end
