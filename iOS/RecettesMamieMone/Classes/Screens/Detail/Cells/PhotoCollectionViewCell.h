//
//  PhotoCollectionViewCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

#define kPhotoCollectionViewCellIdentifier @"kPhotoCollectionViewCellIdentifier"

@interface PhotoCollectionViewCell : UICollectionViewCell

- (void)setup:(Photo *)photo;

@end
