//
//  HardnessParser.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/20/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hardness.h"

@interface HardnessParser : NSObject

@property (nonatomic, readonly) NSArray<Hardness *> * hardnesses;

- (instancetype)initWithDictionary:(NSDictionary *)value;

- (Hardness *)hardnessTypeWithId:(NSString *)identifier;


@end
