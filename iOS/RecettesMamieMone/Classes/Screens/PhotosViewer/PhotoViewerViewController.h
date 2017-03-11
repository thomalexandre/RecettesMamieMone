//
//  PhotoViewerViewController.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/3/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface PhotoViewerViewController : UIViewController

- (instancetype)initWithRecipe:(Recipe *)recipe withPhotoIndex:(NSUInteger)photoIndex;

@end
