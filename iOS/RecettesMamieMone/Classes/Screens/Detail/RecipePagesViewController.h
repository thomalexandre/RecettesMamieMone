//
//  RecipePagesViewController.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 5/31/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface RecipePagesViewController : UIViewController

- (instancetype)initWithRecipes:(NSArray<Recipe *> *)recipes startIndex:(NSInteger)startIndex;

@end
