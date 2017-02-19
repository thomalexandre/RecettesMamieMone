//
//  RecipeTypesParser.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeType.h"

@interface RecipeTypesParser : NSObject

@property (nonatomic, readonly) NSArray<RecipeType *> * recipeTypes;

- (instancetype)initWithDictionary:(NSDictionary *)value;

- (RecipeType *)recipeTypeWithId:(NSString *)identifier;

@end
