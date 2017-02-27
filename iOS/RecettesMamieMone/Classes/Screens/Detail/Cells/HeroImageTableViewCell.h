//
//  HeroImageTableViewCell.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

#define kHeroImageTableViewCellIdentifier @"kHeroImageTableViewCellIdentifier"

@interface HeroImageTableViewCell : UITableViewCell

- (void)setup:(Recipe *)recipe;

@end
