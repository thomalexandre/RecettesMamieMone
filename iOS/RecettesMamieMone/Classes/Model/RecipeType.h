//
//  Type.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecipeType : NSObject <NSCopying>

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, strong)   NSString *name;
@property (nonatomic, strong)   NSString *image;
@property (nonatomic, assign)   BOOL selected;  /// NO as default

+ (instancetype)recipeType:(NSString *)identifier withDictionary:(NSDictionary *)dict;


@end
