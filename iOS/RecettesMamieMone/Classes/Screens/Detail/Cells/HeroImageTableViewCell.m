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

@interface HeroImageTableViewCell ()
    
@property (nonatomic, strong) UIImageView *heroImageView;
@property (nonatomic, strong) UIImageView *borderImageView;

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
    [self.heroImageView snap];
    [self.heroImageView setHeightConstant:300];
    
    self.borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hero-border-bottom"]];
    self.borderImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.borderImageView.clipsToBounds = YES;
    [self.contentView addSubviewAutoLayout:self.borderImageView];
    [self.borderImageView snapBottom];
    [self.borderImageView snapLeft];
    [self.borderImageView snapRight];
    [self.borderImageView setHeightConstant:10];
}

- (void)setup:(Recipe *)recipe
{
    //UIImage *image = [UIImage imageNamed:@"placeholder"];
    //self.heroImageView.image = image;
    
    [[StorageManager instance] urlForPath:[recipe thumbnailPath] completion:^(NSURL *url, NSError *error) {
        [self.heroImageView sd_setImageWithURL:url];
        NSLog(@"Loading... %@", url);
    }];
    
    [self updateConstraintsIfNeeded];
}
    
- (void)prepareForReuse
{
    self.heroImageView.image = nil;
}
    
@end
