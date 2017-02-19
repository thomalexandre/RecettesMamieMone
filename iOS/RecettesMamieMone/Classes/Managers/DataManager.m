//
//  DataManager.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "DataManager.h"
#import "RecipesParser.h"
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
        self.database = [[FIRDatabase database] reference];
    }
    return self;
}

#pragma mark - Recipes Management

- (void)fetchRecipes:(void (^)(NSArray<Recipe *> *recipes))completion
{
    [[self.database child:@"recipes"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshotRecipes) {
        
        RecipesParser *parser = [[RecipesParser alloc] initWithDictionary:snapshotRecipes.value];
        
        if(completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(parser.recipes);
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
