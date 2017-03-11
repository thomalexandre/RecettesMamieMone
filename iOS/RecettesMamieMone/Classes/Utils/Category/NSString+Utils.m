//
//  NSString+Utils.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (id)toJSON
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return json;
}

- (NSArray *)toArray
{
    id json = [self toJSON];
    return ([json isKindOfClass:[NSArray class]]) ? json : nil;
}

- (NSDictionary *)toDictionary
{
    id json = [self toJSON];
    return ([json isKindOfClass:[NSDictionary class]]) ? json : nil;
}




@end
