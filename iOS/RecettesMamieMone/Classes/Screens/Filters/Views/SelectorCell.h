//
//  SelectorCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/4/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeType.h"

#define kSelectorCellIdentifier @"kSelectorCellIdentifier"

@interface SelectorCell : UICollectionViewCell

- (void)setup:(RecipeType *)recipeType;

@end
