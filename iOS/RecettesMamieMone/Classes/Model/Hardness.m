//
//  Hardness.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/20/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "Hardness.h"

@interface Hardness ()

@property (nonatomic, strong, readwrite) NSString *identifier;

@end

@implementation Hardness

+ (instancetype)hardness:(NSString *)identifier withDictionary:(NSDictionary *)dict;
{
    Hardness *hardness = [[Hardness alloc] initWithDictionary:dict];
    hardness.identifier = identifier;
    return hardness;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if(self) {
        self.name = dict[@"name"];
        self.selected = NO;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    Hardness *h = [[[self class] allocWithZone:zone] init];
    if(h) {
        h.identifier = self.identifier;
        h.name = self.name;
        h.selected = self.selected;
    }
    return h;
}

@end

