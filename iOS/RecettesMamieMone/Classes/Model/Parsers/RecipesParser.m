//
//  RecipesParser.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipesParser.h"
#import "RecipeTypesParser.h"
#import "HardnessParser.h"
#import "ConfigurationManager.h"

@interface RecipesParser ()

@property (nonatomic, strong, readwrite) NSArray<Recipe *> * recipes;

@end

@implementation RecipesParser

- (instancetype)initWithDictionary:(NSDictionary *)value
{
    self = [super init];
    if(self) {
        [self parse:value];
    }
    return self;
}


- (void)parse:(NSDictionary *)value
{
    RecipeTypesParser *recipeTypesParser = [[RecipeTypesParser alloc] initWithDictionary:value[@"types"]];
    HardnessParser    *hardnessParser    = [[HardnessParser alloc] initWithDictionary:value[@"hardnesses"]];
    
    // Load
    NSDictionary *recipesList = value[@"list"];
    NSMutableArray *recipes = [NSMutableArray new];
    for(NSString *identifier in [recipesList allKeys]) {
        
        NSDictionary *dict  = recipesList[identifier];
        Recipe *recipe      = [Recipe recipe:identifier withDictionary:dict];
        
#if !(TARGET_OS_SIMULATOR)
        if(recipe.live)
#endif
        {
            recipe.type         = [recipeTypesParser recipeTypeWithId:dict[@"type"]];
            recipe.hardness     = [hardnessParser hardnessTypeWithId:dict[@"hardness"]];
            [recipes addObject:recipe];
        }
    }
    
    // sort array
    self.recipes = [recipes sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        Recipe *first  = (Recipe*)a ;
        Recipe *second = (Recipe*)b ;
        return [first.title compare:second.title];
    }];
}

@end
