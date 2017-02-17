//
//  Recipe.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "Recipe.h"

@interface Recipe ()

@property (nonatomic, strong) NSDictionary *rawData;

@end

@implementation Recipe

+ (instancetype)recipeWithDictionary:(NSDictionary *)dict
{
    return [[Recipe alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self) {
        
        self.title       = dict[@"title"];
        self.ingredients = dict[@"ingredients"];
        self.preparation = dict[@"preparation"];
        
        self.rawData     = dict;
    }
    return self;
}

@end
