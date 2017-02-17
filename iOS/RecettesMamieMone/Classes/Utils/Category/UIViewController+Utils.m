//
//  UIViewController+Utils.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "UIView+Layout.h"

@implementation UIViewController (Utils)

- (void)addContentController:(UIViewController *)content toView:(UIView *)view
{
    [self addContentController:content toView:view withTopMargin:0 withRightMargin:0 withBottomMargin:0 withleftMargin:0];
}

- (void)addContentController:(UIViewController *)content toView:(UIView *)view withTopMargin:(float)top withRightMargin:(float)right withBottomMargin:(float)bottom withleftMargin:(float)left
{
    [self addChildViewController:content];
    [view addSubview:content.view];
    [content didMoveToParentViewController:self];
    
    [content.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [content.view snapTopConstant:top];
    [content.view snapRightConstant:right];
    [content.view snapLeftConstant:left];
    [content.view snapBottomConstant:bottom];
}

- (void)addContentController:(UIViewController*)content
{
    [self addContentController:content toView:self.view];
}

- (void)removeContentController:(UIViewController*)content
{
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}

@end
