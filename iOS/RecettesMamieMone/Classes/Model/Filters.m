//
//  Filters.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/5/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "Filters.h"

@interface Filters ()

@property (nonatomic, strong) NSArray<RecipeType *> *recipeTypes;
@property (nonatomic, strong) NSArray<Hardness *>   *hardnesses;

@property (nonatomic, strong) NSArray<RecipeType *> *recipeTypes_backup;
@property (nonatomic, strong) NSArray<Hardness *>   *hardnesses_backup;

@end

@implementation Filters

- (instancetype)initWithRecipeTypes:(NSArray<RecipeType *> *)recipeTypes hardnesses:(NSArray<Hardness *> *)hardnesses
{
    self = [super init];
    if(self) {
        self.recipeTypes = recipeTypes;
        self.hardnesses  = hardnesses;
        
        self.recipeTypes_backup = [[NSArray alloc] initWithArray:recipeTypes copyItems:YES];
        self.hardnesses_backup  = [[NSArray alloc] initWithArray:hardnesses copyItems:YES];
    }
    return self;
}

- (NSUInteger)numberOfRecipeTypes
{
    return [self.recipeTypes count];
}

- (RecipeType *)recipeAtIndex:(NSUInteger)index
{
    return index < [self.recipeTypes count] ? self.recipeTypes[index] : nil;
}

- (RecipeType *)selectDeselectRecipeAtIndex:(NSUInteger)index
{
    RecipeType *recipeType = [self recipeAtIndex:index];
    recipeType.selected = !recipeType.selected;
    return recipeType;
}

- (NSUInteger)numberOfHardnesses
{
    return [self.hardnesses count];
}

- (Hardness *)hardnessAtIndex:(NSUInteger)index
{
    return index < [self.hardnesses count] ? self.hardnesses[index] : nil;
}

- (Hardness *)selectDeselectHardnessAtIndex:(NSUInteger)index
{
    Hardness *hardness = [self hardnessAtIndex:index];
    hardness.selected = !hardness.selected;
    for(Hardness * h in self.hardnesses) {
        if(h != hardness) {
            h.selected = NO;
        }
    }
    return hardness;
}

- (void)reset
{
    self.recipeTypes = [[NSArray alloc] initWithArray:self.recipeTypes_backup copyItems:YES];
    self.hardnesses  = [[NSArray alloc] initWithArray:self.hardnesses_backup copyItems:YES];
}

- (void)apply
{
    
    self.recipeTypes_backup = [[NSArray alloc] initWithArray:self.recipeTypes copyItems:YES];
    self.hardnesses_backup  = [[NSArray alloc] initWithArray:self.hardnesses copyItems:YES];
}

- (BOOL)hasFilters
{
    for(RecipeType *t in self.recipeTypes_backup) if(t.selected) return YES;
    for(Hardness *h in self.hardnesses_backup) if(h.selected) return YES;
    return NO;
}

- (NSArray<Recipe *> *)filterRecipes:(NSArray<Recipe *> *)allRecipes
{
    NSMutableArray *result = [NSMutableArray new];
    
    /// filter based on the user choise
    for(Recipe *recipe in allRecipes) {
        if([self allowRecipe:recipe]) {
            [result addObject:recipe];
        }
    }
    
    /// sorting the results... Type, hardness, alphabetical
    return [result sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        Recipe *first  = (Recipe*)a;
        Recipe *second = (Recipe*)b;
        
        NSComparisonResult typeSortingResult = [first.type.identifier compare:second.type.identifier];
        if(typeSortingResult != NSOrderedSame) {
            return typeSortingResult;
        }
        
        NSComparisonResult hardnessSortingResult = [first.hardness.identifier compare:second.hardness.identifier];
        if(hardnessSortingResult != NSOrderedSame) {
            return hardnessSortingResult;
        }
        
        return [first.title compare:second.title];
    }];
}

- (BOOL)allowRecipe:(Recipe *)recipe
{
    BOOL result = NO;
    do {
        if(![self allowRecipeForType:recipe.type])
            break;
        
        if(![self allowRecipeForHardness:recipe.hardness])
            break;
        
        result = YES;
        
    } while (false);
    
    return result;
}

- (BOOL)allowRecipeForType:(RecipeType *)type
{
    NSMutableArray *allowedTypes = [NSMutableArray new];
    for(RecipeType * t in self.recipeTypes) {
        if(t.selected) {
            [allowedTypes addObject:t];
        }
    }
    
    if([allowedTypes count] == 0) {
        return YES;
    }
    
    for(RecipeType *t in allowedTypes) {
        if([t.identifier isEqualToString:type.identifier]) {
            return YES;
        }
    }
    return NO;
    
}

- (BOOL)allowRecipeForHardness:(Hardness *)hardness
{
    for(Hardness * h in self.hardnesses) {
        if(h.selected) {
            return [hardness.identifier isEqualToString:h.identifier];
        }
    }
    
    return YES;
}

@end
