//
//  RecipesViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/17/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipesViewController.h"
#import "DataManager.h"
#import "UIView+Layout.h"
#import "RecipeViewController.h"
#import "FiltersViewController.h"
#import "SearchViewController.h"

@interface RecipesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Recipe *> *recipes;

@end

@implementation RecipesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Recettes";

    [self setupTableView];
    [self setupNavBar];
    
    [self reloadData];
}

- (void)setupTableView
{
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubviewAutoLayout:self.tableView];
    [self.tableView snap];
}

- (void)setupNavBar
{
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(searchDidPress)];
    self.navigationItem.leftBarButtonItem = searchButton;
    
    UIBarButtonItem *showFiltresButton = [[UIBarButtonItem alloc] initWithTitle:@"Filtres" style:UIBarButtonItemStyleDone target:self action:@selector(filtresDidPress)];
    self.navigationItem.rightBarButtonItem = showFiltresButton;
}

- (void)reloadData
{
    [[DataManager instance] fetchRecipes:^(NSArray<Recipe *> *recipes) {
        self.recipes = recipes;
        [self.tableView reloadData];
    }];
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Recipe *recipe = self.recipes[indexPath.row];
    RecipeViewController *recipeViewController = [[RecipeViewController alloc] initWithRecipe:recipe];
    [self.navigationController pushViewController:recipeViewController animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Recipe *recipe = self.recipes[indexPath.row];
    
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.textLabel.text = recipe.title;
    
    return cell;
}

@end
