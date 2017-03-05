//
//  Filters.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/5/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeType.h"
#import "Recipe.h"
#import "Hardness.h"

@interface Filters : NSObject


- (instancetype)initWithRecipeTypes:(NSArray<RecipeType *> *)recipeTypes hardnesses:(NSArray<Hardness *> *)hardnesses;

- (NSUInteger)numberOfRecipeTypes;
- (RecipeType *)recipeAtIndex:(NSUInteger)index;
- (RecipeType *)selectDeselectRecipeAtIndex:(NSUInteger)index;

- (NSUInteger)numberOfHardnesses;
- (Hardness *)hardnessAtIndex:(NSUInteger)index;
- (Hardness *)selectDeselectHardnessAtIndex:(NSUInteger)index;

- (void)reset;
- (void)apply;

/// Filter all recipes based on the current user choise.
- (NSArray<Recipe *> *)filterRecipes:(NSArray<Recipe *> *)allRecipes;

@end
