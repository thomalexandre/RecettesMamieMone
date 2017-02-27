//
//  RecipeMetadataTableViewCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

#define kRecipeMetadataTableViewCellIdentifier @"kRecipeMetadataTableViewCellIdentifier"

@interface RecipeMetadataTableViewCell : UITableViewCell

- (void)setup:(Recipe *)recipe;

@end
