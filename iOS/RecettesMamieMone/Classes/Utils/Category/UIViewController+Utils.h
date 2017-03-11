//
//  UIViewController+Utils.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Layout.h"

@interface UIViewController (Utils)

/// Add content view controller as a sub view controller. DO not add any autolayout
- (void)addContentController:(UIViewController *)content;

/// Add content view controller as a sub view controller and snap.
- (void)snapContentController:(UIViewController *)content;

// Same as above and add margin.
//- (void)addContentController:(UIViewController *)content
//               withTopMargin:(float)top
//             withRightMargin:(float)right
//            withBottomMargin:(float)bottom
//              withleftMargin:(float)left;

// Remove the content view controller from the current view controller.
- (void)removeContentController:(UIViewController *)content;

@end
