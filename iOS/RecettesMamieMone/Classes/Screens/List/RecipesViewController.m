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
#import <SDWebImage/UIImageView+WebCache.h>
#import "StorageManager.h"

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

- (void)reloadData
{
    [[DataManager instance] fetchRecipes:^(NSArray<Recipe *> *recipes) {
        self.recipes = recipes;
        [self.tableView reloadData];
    }];
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
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"something"];
    
    cell.textLabel.text = recipe.title;
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    
    [[StorageManager instance] urlForPath:[recipe thumbnailPath] completion:^(NSURL *url, NSError *error) {
        [cell.imageView sd_setImageWithURL:url];
        NSLog(@"Loading... %@", url);
    }];
    
    return cell;
}

@end
