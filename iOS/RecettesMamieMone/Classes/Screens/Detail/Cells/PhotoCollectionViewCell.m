//
//  PhotoCollectionViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "UIView+Layout.h"

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
    self.imageview.image = [UIImage imageNamed:@"placeholder"];
    [self addSubviewAutoLayout:self.imageview];
    [self.imageview snap];
    
}

@end
