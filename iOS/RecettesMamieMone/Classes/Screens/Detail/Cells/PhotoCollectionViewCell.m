//
//  PhotoCollectionViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "UIView+Layout.h"
#import "StorageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ThemeManager.h"

@interface PhotoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageview;

@end

@implementation PhotoCollectionViewCell

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
    
    // image
    self.imageview = [UIImageView new];
    self.imageview.contentMode = UIViewContentModeScaleAspectFill;
    self.imageview.clipsToBounds = YES;
    self.imageview.layer.cornerRadius  = 4.0f;
    self.imageview.layer.masksToBounds = YES;
//    self.imageview.image = [UIImage imageNamed:@"placeholder"];
    self.imageview.backgroundColor = [[ThemeManager instance] cardBackground];
    [self addSubviewAutoLayout:self.imageview];
    [self.imageview snap];
}

- (void)setup:(Photo *)photo
{
    __weak PhotoCollectionViewCell * wSelf = self;
    [[StorageManager instance] urlForPath:[photo path] completion:^(NSURL *url, NSError *error) {
        [wSelf.imageview sd_setImageWithURL:url];
        NSLog(@"Loading... %@", url);
    }];
}

- (void)prepareForReuse
{
    self.imageview.image = nil;
}

@end
