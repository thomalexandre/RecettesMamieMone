//
//  Hardness.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/20/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hardness : NSObject

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, strong)   NSString *name;

+ (instancetype)hardness:(NSString *)identifier withDictionary:(NSDictionary *)dict;

@end
