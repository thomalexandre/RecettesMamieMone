//
//  RootViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/15/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RootViewController.h"
#import "RecipesViewController.h"
#import "UIViewController+Utils.h"

@interface RootViewController ()

@end

@implementation RootViewController

+ (instancetype)instance
{
    static RootViewController *_instance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^
    {
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blueColor];
    
    RecipesViewController *recipes = [RecipesViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:recipes];
    [self addContentController:nav];
}


@end