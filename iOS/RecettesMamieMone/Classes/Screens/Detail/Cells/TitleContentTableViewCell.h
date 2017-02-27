//
//  TitleContentTableViewCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

#define kTitleContentTableViewCellIdentifier @"kTitleContentTableViewCellIdentifier"

typedef NS_ENUM(NSInteger, RecipeContentType) {
    RecipeContentTypeIngredients,
    RecipeContentTypePreparation,
};

@interface TitleContentTableViewCell : UITableViewCell

- (void)setup:(Recipe *)recipe type:(RecipeContentType)type;

@end
