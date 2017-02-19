//
//  Recipe.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeType.h"

@interface Recipe : NSObject

@property (nonatomic, readonly) NSString   *identifier;
@property (nonatomic, strong)   NSString   *title;
@property (nonatomic, strong)   NSString   *ingredients;
@property (nonatomic, strong)   NSString   *preparation;
@property (nonatomic, strong)   RecipeType *type;

+ (instancetype)recipe:(NSString *)identifier withDictionary:(NSDictionary *)dict;

- (void)setDetails:(NSDictionary *)dict;

@end
