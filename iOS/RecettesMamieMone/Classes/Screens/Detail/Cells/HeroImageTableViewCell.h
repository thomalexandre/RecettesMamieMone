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

// update the view based on scrolling. Returns YES, if the view has become hidden fully.
- (BOOL)viewDidScroll:(CGFloat)scrollY;

@end
