//
//  DataManager.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "DataManager.h"
#import "RecipesParser.h"
#import "RecipeTypesParser.h"
#import "HardnessParser.h"
@import FirebaseDatabase;

@interface DataManager ()

@property (strong, nonatomic) FIRDatabaseReference *database;

@end

@implementation DataManager

+ (instancetype)instance
{
    static DataManager *_instance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _instance = [[self alloc] init];
                  });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        [FIRDatabase database].persistenceEnabled = YES; // To test on device
        self.database = [[FIRDatabase database] reference];
        
//        [self setupFilters];
    }
    return self;
}

#pragma mark - Filters

//- (void)setupFilters
//{   
//    [self fetchFilters:^(NSArray<RecipeType *> *recipeTypes, NSArray<Hardness *> * hardnesses) {
//        self.filters = [[Filters alloc] initWithRecipeTypes:recipeTypes hardnesses:hardnesses];
//    }];
//}
//
//- (void)fetchFilters:(void (^)(NSArray<RecipeType *> *recipeTypes, NSArray<Hardness *> * hardnesses))completion
//{
//    [[self.database child:@"recipes"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshotTypes) {
//        
//        RecipeTypesParser *recipeTypesParser = [[RecipeTypesParser alloc] initWithDictionary:snapshotTypes.value[@"types"]];
//        HardnessParser    *hardnessParser    = [[HardnessParser alloc] initWithDictionary:snapshotTypes.value[@"hardnesses"]];
//        if(completion) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completion(recipeTypesParser.recipeTypes, hardnessParser.hardnesses);
//            });
//        }
//    }];
//}

#pragma mark - Recipes Management

- (void)fetchRecipes:(void (^)(NSArray<Recipe *> *recipes))completion
{
    [[self.database child:@"recipes"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshotRecipes) {
        
        if(!self.filters) {
            RecipeTypesParser *recipeTypesParser = [[RecipeTypesParser alloc] initWithDictionary:snapshotRecipes.value[@"types"]];
            HardnessParser    *hardnessParser    = [[HardnessParser alloc]    initWithDictionary:snapshotRecipes.value[@"hardnesses"]];
            self.filters = [[Filters alloc] initWithRecipeTypes:recipeTypesParser.recipeTypes hardnesses:hardnessParser.hardnesses];
        }
        
        RecipesParser *parser = [[RecipesParser alloc] initWithDictionary:snapshotRecipes.value];
        
        NSArray<Recipe *> *filteredRecipes = [self.filters filterRecipes:parser.recipes];
        
        if(completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(filteredRecipes);
            });
        }
    }];
}

- (void)fetchDetails:(Recipe *)recipe completion:(void (^)(Recipe *recipe))completion
{
    [[[self.database child:@"details"] child:recipe.identifier] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshotRecipe) {
        
        [recipe setDetails:snapshotRecipe.value];
        if(completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(recipe);
            });
        }
    }];
}


@end
