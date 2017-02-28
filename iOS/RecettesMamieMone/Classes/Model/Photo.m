//
//  Photo.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "Photo.h"

@interface Photo ()

@property (nonatomic, strong) NSString *prefix;

@end

@implementation Photo

+ (instancetype)photosWithDictionary:(NSDictionary *)dict prefix:(NSString *)prefix
{
    Photo *photo = [Photo new];
    photo.filename = dict[@"filename"];
    photo.prefix   = prefix;
    
    return photo;
}

- (NSString *)path

{
    return [NSString stringWithFormat:@"%@%@", self.prefix, self.filename];
}

@end
