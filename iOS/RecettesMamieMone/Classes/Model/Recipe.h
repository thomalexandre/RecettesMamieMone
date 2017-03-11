//
//  Recipe.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeType.h"
#import "Hardness.h"
#import "Photo.h"

@interface Recipe : NSObject

@property (nonatomic, readonly) NSString   *identifier;
@property (nonatomic, readonly) NSString   *title;
@property (nonatomic, readonly) NSString   *ingredients;
@property (nonatomic, readonly) NSString   *preparation;
@property (nonatomic, readonly) NSString   *thumbnail;
@property (nonatomic, readonly) BOOL        live;
@property (nonatomic, strong)   RecipeType *type;
@property (nonatomic, strong)   Hardness   *hardness;
@property (nonatomic, strong)   NSArray<Photo *> *photos;

+ (instancetype)recipe:(NSString *)identifier withDictionary:(NSDictionary *)dict;

- (void)setDetails:(NSDictionary *)dict;

@end
