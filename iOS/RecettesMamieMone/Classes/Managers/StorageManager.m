//
//  StorageManager.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "StorageManager.h"
#import "SDWebImageManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
@import FirebaseStorage;

@interface StorageManager ()

@property (nonatomic, strong) FIRStorageReference *storageRef;

@end

@implementation StorageManager

+ (instancetype)instance
{
    static StorageManager *_instance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
                  {
                      _instance = [[self alloc] init];
                  });
    
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if(self) {
        FIRStorage *storage = [FIRStorage storage];
        self.storageRef = [storage referenceForURL:@"gs://recettesmamie-d0853.appspot.com"];
        
        SDWebImageManager.sharedManager.cacheKeyFilter = ^(NSURL *url) {
            url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
            return [url absoluteString];
        };
    }
    return self;
}

- (void)urlForPath:(NSString *)path completion:(void (^)(NSURL *url, NSError *error))completion
{
    FIRStorageReference *reference = [self.storageRef child:path];
    if(reference) {
        [reference downloadURLWithCompletion:^(NSURL *URL, NSError *error){
            dispatch_async(dispatch_get_main_queue(), ^{
                if(completion) {
                    completion(URL, error);
                }
            });
        }];
    } else if(completion) {
        NSError *error = [NSError errorWithDomain:@"athomas.me" code:1 userInfo:@{NSLocalizedFailureReasonErrorKey:@"Not a valid path"}];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil, error);
        });
    }
}

@end
