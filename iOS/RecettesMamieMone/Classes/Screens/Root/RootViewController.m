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
#import "ThemeManager.h"

#define kFiltersWidth       300.f
#define kAnimationDuration  0.3f

@interface RootViewController ()

@property (nonatomic, strong) RecipesViewController *recipes;
@property (nonatomic, strong) FiltersViewController *filters;

@property (nonatomic, strong) UIButton              *backgroundButton;
@property (nonatomic, strong) NSLayoutConstraint    *filterLeftConstraint;
@property (nonatomic, assign) BOOL                   menuIsOpened;

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
    
    self.recipes = [RecipesViewController new];
    [self snapContentController:self.recipes];
    
    self.title = @"Les Recettes de Mamie Mone";
    
    [self setupNavBar];
}

- (void)setupNavBar
{
//    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(searchDidPress)];
//    self.navigationItem.leftBarButtonItem = searchButton;
    
    UIImage *image = [UIImage imageNamed:(!self.menuIsOpened ? @"icon-filter" : @"icon-close")];
    UIBarButtonItem *showFiltresButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(filtresDidPress)];
    
    self.navigationItem.rightBarButtonItem = showFiltresButton;
}


- (void)loadFiltersController
{
    if(!_filters) {
        _filters = [FiltersViewController new];
        [self addContentController:_filters];
        [_filters.view snapTop];
        [_filters.view snapBottom];
        [_filters.view setWidthConstant:kFiltersWidth];
        self.filterLeftConstraint = [_filters.view snapLeftToRight:0 relativeToView:self.view];
        [self.view layoutIfNeeded];
    }
}

- (void)loadBackgroundButton
{
    if(!_backgroundButton) {
        _backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundButton.backgroundColor = [[ThemeManager instance] backgroundClickabke];
        [self.view addSubviewAutoLayout:_backgroundButton];
        [_backgroundButton snap];
        [_backgroundButton addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    _backgroundButton.hidden = NO;
}

#pragma mark - Actions

- (void)searchDidPress
{
    SearchViewController *vc = [SearchViewController new];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)filtresDidPress
{
//    FiltersViewController *vc = [FiltersViewController new];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_filters];
//    [self.navigationController presentViewController:nav animated:YES completion:nil];

    if(!self.menuIsOpened) {
        [self openMenu];
    } else {
        [self closeMenu];
    }
}

- (void)openMenu
{
    if(!self.menuIsOpened) {
        [self loadBackgroundButton];
        [self loadFiltersController];
        
        [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:0 animations:^{
            self.filterLeftConstraint.constant = -kFiltersWidth;
            [self.view layoutIfNeeded];
        } completion:nil];
        self.menuIsOpened = YES;
        [self setupNavBar];
    }
}

- (void)closeMenu
{
    if(self.menuIsOpened) {
        _backgroundButton.hidden = YES;
        [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:0 animations:^{
            self.filterLeftConstraint.constant = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
        self.menuIsOpened = NO;
        [self setupNavBar];
    }
}

@end
