//
//  RecipeViewController.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/17/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "UIDetailHeaderView.h"

@interface RecipeViewController : UIViewController

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, weak) UIDetailHeaderView *header;

- (instancetype)initWithRecipe:(Recipe *)recipe;

- (void)scrollToTop;
- (void)updateHeaderBasedOnScrolling;

@end
