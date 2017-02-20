//
//  HardnessParser.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/20/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "HardnessParser.h"

@interface HardnessParser ()

@property (nonatomic, strong, readwrite) NSArray<Hardness *> * hardnesses;

@end

@implementation HardnessParser

- (instancetype)initWithDictionary:(NSDictionary *)value
{
    self = [super init];
    if(self) {
        [self parse:value];
    }
    return self;
}

- (Hardness *)hardnessTypeWithId:(NSString *)identifier
{
    for(Hardness *h in self.hardnesses) {
        if([h.identifier isEqualToString:identifier]) {
            return h;
        }
    }
    return nil;
}

#pragma mark - Private

- (void)parse:(NSDictionary *)value
{
    NSMutableArray *array = [NSMutableArray new];
    
    for(NSString *identifier in [value allKeys]) {
        NSDictionary *dict = value[identifier];
        Hardness *h = [Hardness hardness:identifier withDictionary:dict];
        [array addObject:h];
    }
    
    // sort array
    self.hardnesses = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        Hardness *first  = (Hardness*)a ;
        Hardness *second = (Hardness*)b ;
        return [first.identifier compare:second.identifier];
    }];
}

@end
