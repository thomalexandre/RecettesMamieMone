//
//  StorageManager.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorageManager : NSObject

+ (instancetype)instance;

- (void)setImage:(UIImageView *)imageView path:(NSString *)path;

@end
