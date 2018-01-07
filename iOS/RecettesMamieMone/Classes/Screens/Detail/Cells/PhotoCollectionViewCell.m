//
//  PhotoCollectionViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "StorageManager.h"

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
    self.imageview.backgroundColor = [UIColor clearColor];
    [self addSubviewAutoLayout:self.imageview];
    [self.imageview snap];
}

- (void)setup:(Photo *)photo mode:(UIViewContentMode)mode
{
     [[StorageManager instance] setImage:self.imageview path:[photo path]];
    self.imageview.contentMode = mode;
}

- (void)prepareForReuse
{
    self.imageview.image = nil;
}

@end
