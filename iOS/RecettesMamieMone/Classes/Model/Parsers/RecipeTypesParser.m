//
//  RecipeTypesParser.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeTypesParser.h"

@interface RecipeTypesParser ()

@property (nonatomic, strong, readwrite) NSArray<RecipeType *> * recipeTypes;

@end

@implementation RecipeTypesParser

- (instancetype)initWithDictionary:(NSDictionary *)value
{
    self = [super init];
    if(self) {
        [self parse:value];
    }
    return self;
}

- (RecipeType *)recipeTypeWithId:(NSString *)identifier
{
    for(RecipeType *r in self.recipeTypes) {
        if([r.identifier isEqualToString:identifier]) {
            return r;
        }
    }
    return nil;
}

#pragma mark - Private

- (void)parse:(NSDictionary *)value
{
    NSMutableArray *array = [NSMutableArray new];
    
    for(NSString *identifier in [value allKeys]) {
        NSDictionary *dict = value[identifier];
        RecipeType *r = [RecipeType recipeType:identifier withDictionary:dict];
        [array addObject:r];
    }
    
    // sort array
    self.recipeTypes = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        RecipeType *first  = (RecipeType*)a ;
        RecipeType *second = (RecipeType*)b ;
        return [first.identifier compare:second.identifier];
    }];
}


@end
