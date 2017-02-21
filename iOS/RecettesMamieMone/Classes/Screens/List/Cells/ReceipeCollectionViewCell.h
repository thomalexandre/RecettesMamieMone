//
//  ReceipeCollectionViewCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/21/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

#define kReceipeCollectionViewCellIdentifier @"kReceipeCollectionViewCellIdentifier"

@interface ReceipeCollectionViewCell : UICollectionViewCell

- (void)setup:(Recipe *)recipe;

@end
