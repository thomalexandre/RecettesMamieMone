//
//  PhotosTableViewCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

#define kPhotosTableViewCellIdentifier @"kPhotosTableViewCellIdentifier"

@protocol PhotosTableViewCellDelegate <NSObject>

- (void)photoDidTapAtIndex:(NSUInteger)photoIndex;

@end

@interface PhotosTableViewCell : UITableViewCell

@property (nonatomic, weak) id<PhotosTableViewCellDelegate> delegate;

- (void)setup:(Recipe *)recipe;

@end
