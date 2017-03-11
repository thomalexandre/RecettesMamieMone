//
//  UIViewController+Utils.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "UIView+Utils.h"


@implementation UIViewController (Utils)

- (void)addContentController:(UIViewController *)content
{
    [self addChildViewController:content];
    [self.view addSubviewAutoLayout:content.view];
    [content didMoveToParentViewController:self];
}

- (void)snapContentController:(UIViewController*)content
{
//    [self addContentController:content withTopMargin:0 withRightMargin:0 withBottomMargin:0 withleftMargin:0];
    [self addContentController:content];
    [content.view snap];
}

//- (void)addContentController:(UIViewController *)content withTopMargin:(float)top withRightMargin:(float)right withBottomMargin:(float)bottom withleftMargin:(float)left
//{
//    [self addChildViewController:content];
//    
//    [content.view snapTopConstant:top];
//    [content.view snapRightConstant:right];
//    [content.view snapLeftConstant:left];
//    [content.view snapBottomConstant:bottom];
//}

- (void)removeContentController:(UIViewController*)content
{
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}

@end
