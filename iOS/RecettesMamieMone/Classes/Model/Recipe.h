//
//  Recipe.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *ingredients;
@property (nonatomic, strong) NSString *preparation;

+ (instancetype)recipeWithDictionary:(NSDictionary *)dict;

@end