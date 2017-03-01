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
#import "ThemeManager.h"

#define kHeroImageHeight   300.f
#define kHeroNavbarHeight  64.f

@interface HeroImageTableViewCell ()

@property (nonatomic, strong) UIView      *overView;
@property (nonatomic, strong) UIImageView *heroImageView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

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
    
    // image....
    self.heroImageView = [UIImageView new];
    self.heroImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.heroImageView.clipsToBounds = YES;
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
}

- (void)setup:(Recipe *)recipe
{
    //UIImage *image = [UIImage imageNamed:@"placeholder"];
    //self.heroImageView.image = image;
    
    __weak HeroImageTableViewCell * wSelf = self;
    [[StorageManager instance] urlForPath:[recipe thumbnail] completion:^(NSURL *url, NSError *error) {
        [wSelf.heroImageView sd_setImageWithURL:url];
        NSLog(@"Loading... %@", url);
    }];
    
    [self updateConstraintsIfNeeded];
}
    
- (void)prepareForReuse
{
    //self.heroImageView.image = nil;
}

- (BOOL)viewDidScroll:(CGFloat)scrollY
{
    self.topConstraint.constant    = scrollY > 0 ? 0.0 : scrollY;
    self.heightConstraint.constant = scrollY > 0 ? kHeroImageHeight : kHeroImageHeight + fabs(scrollY);
    
    //CGFloat alpha = scrollY > kHeroImageHeight / 3.f ? (kHeroImageHeight/3.f-(kHeroImageHeight-scrollY)) / (kHeroImageHeight/3.f) : 0;
    CGFloat alpha = scrollY > kHeroImageHeight / 3.f ? (scrollY - kHeroImageHeight / 3.0) / ((kHeroImageHeight - 64) - (kHeroImageHeight / 3.0)) : 0;
    self.overView.backgroundColor = [[ThemeManager instance] navBar:alpha];
    
   // NSLog(@"%f %f", scrollY, alpha);
    
    return alpha >= 1.f;
}


@end
