//
//  DataManager.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "RecipeType.h"

@interface DataManager : NSObject

+ (instancetype)instance;

#pragma mark - Recipes Management

/// load types
- (void)fetchRecipeTypes:(void (^)(NSArray<RecipeType *> *recipeTypes))completion;

/// Load all recipes from the database, and return in the completion block.
- (void)fetchRecipes:(void (^)(NSArray<Recipe *> *recipes))completion;
- (void)fetchDetails:(Recipe *)recipe completion:(void (^)(Recipe *recipe))completion;

@end
