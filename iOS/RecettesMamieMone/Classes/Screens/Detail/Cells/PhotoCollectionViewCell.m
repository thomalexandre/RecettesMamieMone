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
    self.imageview = [UIImageView new];
    self.imageview.contentMode = UIViewContentModeScaleAspectFill;
    self.imageview.clipsToBounds = YES;
    self.imageview.image = [UIImage imageNamed:@"placeholder"];
    [self addSubviewAutoLayout:self.imageview];
    [self.imageview snap];
}

- (void)setup:(Photo *)photo
{
    [[StorageManager instance] urlForPath:[photo path] completion:^(NSURL *url, NSError *error) {
        [self.imageview sd_setImageWithURL:url];
        NSLog(@"Loading... %@", url);
    }];

}

@end
