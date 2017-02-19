//
//  RecipesParser.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"

@interface RecipesParser : NSObject

@property (nonatomic, readonly) NSArray<Recipe *> * recipes;

- (instancetype)initWithDictionary:(NSDictionary *)value;

@end
