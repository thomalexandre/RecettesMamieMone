//
//  SelectorCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/4/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeType.h"
#import "Hardness.h"

#define kSelectorCellIdentifier @"kSelectorCellIdentifier"

@interface SelectorCell : UICollectionViewCell

- (void)setupWithRecipeType:(RecipeType *)recipeType;
- (void)setupWithHardness:(Hardness *)hardness;

@end
