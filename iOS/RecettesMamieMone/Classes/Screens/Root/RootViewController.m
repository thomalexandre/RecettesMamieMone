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
#import "FiltersViewController.h"
#import "SearchViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) RecipesViewController *recipes;

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
    
    self.recipes = [RecipesViewController new];
    [self addContentController:self.recipes];
    
    self.title = @"Recettes";
    
    [self setupNavBar];
}

- (void)setupNavBar
{
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(searchDidPress)];
    self.navigationItem.leftBarButtonItem = searchButton;
    
    UIBarButtonItem *showFiltresButton = [[UIBarButtonItem alloc] initWithTitle:@"Filtres" style:UIBarButtonItemStyleDone target:self action:@selector(filtresDidPress)];
    self.navigationItem.rightBarButtonItem = showFiltresButton;
}

#pragma mark - Actions

- (void)searchDidPress
{
    SearchViewController *vc = [SearchViewController new];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)filtresDidPress
{
    FiltersViewController *vc = [FiltersViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
