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
#import "ReceipeCollectionViewCell.h"
#import "ThemeManager.h"

@interface RecipesViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<Recipe *> *recipes;

@end

@implementation RecipesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Recettes";
    
    [self setupCollectionView];
    
    [self reloadData];
    self.view.backgroundColor = [[ThemeManager instance] background];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [[ThemeManager instance] background];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[ReceipeCollectionViewCell class] forCellWithReuseIdentifier:kReceipeCollectionViewCellIdentifier];
    
    [self.view addSubviewAutoLayout:self.collectionView];
    [self.collectionView snap];
}

- (void)reloadData
{
    [[DataManager instance] fetchRecipes:^(NSArray<Recipe *> *recipes) {
        self.recipes = recipes;
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
    return [self.recipes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Recipe *recipe = self.recipes[indexPath.row];
    ReceipeCollectionViewCell *cell = (ReceipeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kReceipeCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setup:recipe];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Recipe *recipe = self.recipes[indexPath.row];
    RecipeViewController *recipeViewController = [[RecipeViewController alloc] initWithRecipe:recipe];
    [self.navigationController pushViewController:recipeViewController animated:YES];
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


@end
