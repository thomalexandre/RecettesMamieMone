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
    
    if(dict[@"photos"]) {
        self.photos = [self loadPhotos:dict[@"photos"]];
    }
}

- (NSArray *)loadPhotos:(NSArray *)photosList
{
    
    NSMutableArray *array = [NSMutableArray new];
    for(NSDictionary *dict in photosList) {
        Photo *photo = [Photo photosWithDictionary:dict prefix:[self imagePrefix]];
        [array addObject:photo];
    }
    return [array copy];
}

- (NSString *)thumbnailPath
{
    return [NSString stringWithFormat:@"%@thumbnail.jpg", [self imagePrefix]];
}

- (NSString *)imagePrefix
{
    return [NSString stringWithFormat:@"%@/", self.identifier];
}


@end
