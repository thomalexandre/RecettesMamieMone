//
//  DataManager.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "DataManager.h"
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

- (void)recipes:(void (^)(NSArray<Recipe *> *recipes))completion
{
    [[self.database child:@"recipes"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshotRecipes) {
        
        NSMutableArray *recipes = [NSMutableArray new];
        for(NSDictionary *dict in snapshotRecipes.value) {
            Recipe *recipe = [Recipe recipeWithDictionary:dict];
            [recipes addObject:recipe];
        }

        if(completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([recipes copy]);
            });
        }
    }];
}


@end
