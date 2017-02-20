//
//  Recipe.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "Recipe.h"

@interface Recipe ()

@property (nonatomic, strong, readwrite) NSString *identifier;

@end

@implementation Recipe

+ (instancetype)recipe:(NSString *)identifier withDictionary:(NSDictionary *)dict;
{
    Recipe *recipe = [[Recipe alloc] initWithDictionary:dict];
    recipe.identifier = identifier;
    return recipe;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self) {
        self.title = dict[@"title"];
    }
    return self;
}

- (void)setDetails:(NSDictionary *)dict
{
    self.ingredients = dict[@"ingredients"];
    self.preparation = dict[@"preparation"];
}

- (NSString *)thumbnailPath
{
    return [NSString stringWithFormat:@"%@/thumbnail.jpg", self.identifier];
}


@end
