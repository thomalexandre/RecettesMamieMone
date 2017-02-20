//
//  StorageManager.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageManager : NSObject

+ (instancetype)instance;

- (void)urlForPath:(NSString *)path completion:(void (^)(NSURL *url, NSError *error))completion;

@end
