//
//  UIViewController+Utils.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

/// Add content view controller as a sub view controller. view must be in the hierarchy.
- (void)addContentController:(UIViewController *)content toView:(UIView *)view;

// Same as above and add margin.
- (void)addContentController:(UIViewController *)content toView:(UIView *)view
               withTopMargin:(float)top
             withRightMargin:(float)right
            withBottomMargin:(float)bottom
              withleftMargin:(float)left;

/// Add content view controller as a sub view controller.
- (void)addContentController:(UIViewController *)content;

// Remove the content view controller from the current view controller.
- (void)removeContentController:(UIViewController *)content;

@end
