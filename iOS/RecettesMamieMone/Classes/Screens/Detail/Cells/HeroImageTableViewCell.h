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

@protocol HeroImageTableViewCellDelegate <NSObject>

- (void)photoButtonDidSelect;

@end

@interface HeroImageTableViewCell : UITableViewCell

@property (nonatomic, weak) id<HeroImageTableViewCellDelegate> delegate;

- (void)setup:(Recipe *)recipe;

// update the view based on scrolling.
// Return the alpha. if alpha > 1, the view has fully scrolled.
- (CGFloat)viewDidScroll:(CGFloat)scrollY;

@end
