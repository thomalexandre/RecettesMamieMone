//
//  Photo.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *filename;

+ (instancetype)photosWithDictionary:(NSDictionary *)dict prefix:(NSString *)prefix;

- (NSString *)path;

@end
