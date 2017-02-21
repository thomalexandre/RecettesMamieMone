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
#import "ConfigurationManager.h"

@interface RecipesViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Recipe *> *recipes;

@end

@implementation RecipesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Recettes";
    
    [self setupCollectionView];
//    [self setupTableView];
    
    [self reloadData];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.view addSubviewAutoLayout:self.collectionView];
    [self.collectionView snap];
}

//- (void)setupTableView
//{
//    self.tableView = [UITableView new];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.view addSubviewAutoLayout:self.tableView];
//    [self.tableView snap];
//}

- (void)reloadData
{
    [[DataManager instance] fetchRecipes:^(NSArray<Recipe *> *recipes) {
        self.recipes = recipes;
//        [self.tableView reloadData];
        [self.collectionView reloadData];
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self.collectionView performBatchUpdates:^{
            [self.collectionView setCollectionViewLayout:self.collectionView.collectionViewLayout animated:YES];
        } completion:nil];
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.recipes count] * 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Recipe *recipe = self.recipes[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([ConfigurationManager isIphone]) {
        CGFloat width       = (collectionView.frame.size.width - 3 * 16) / 2;
        CGFloat pictheight  = width / 1.5f;
        CGFloat textHeight  = 34.f;
        CGFloat height      = pictheight + textHeight;
        
        return CGSizeMake(width, height);
        
    } else {
        
        CGFloat width       = 220.f;//(collectionView.frame.size.width - 3 * 16) / 2;
        CGFloat pictheight  = width / 1.5f;
        CGFloat textHeight  = 34.f;
        CGFloat height      = pictheight + textHeight;
        
        return CGSizeMake(width, height);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat margin = [ConfigurationManager isIphone] ? 16.f : 20.f;
    return UIEdgeInsetsMake(margin, margin, margin, margin);
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
