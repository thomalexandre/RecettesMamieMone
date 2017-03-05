//
//  RecipeType.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeType.h"

@interface RecipeType ()

@property (nonatomic, strong, readwrite) NSString *identifier;

@end

@implementation RecipeType

+ (instancetype)recipeType:(NSString *)identifier withDictionary:(NSDictionary *)dict;
{
    RecipeType *recipeType = [[RecipeType alloc] initWithDictionary:dict];
    recipeType.identifier = identifier;
    return recipeType;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self) {
        self.name  = dict[@"name"];
        self.image = dict[@"image"];
    }
    return self;
}
@end
