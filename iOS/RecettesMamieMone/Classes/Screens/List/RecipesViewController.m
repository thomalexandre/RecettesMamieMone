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
#import "UIView+Utils.h"
#import "RecipeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "StorageManager.h"
#import "ReceipeCollectionViewCell.h"
#import "RecipePagesViewController.h"
#import "ATKApp.h"

@interface RecipesViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *emptyStateLabel;
@property (nonatomic, strong) NSArray<Recipe *> *recipes;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation RecipesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Recettes";
    
    [self setupEmptyState];
    [self createRefreshControl];
    self.view.backgroundColor = [COLOR background];
}

- (void)setupEmptyState
{
    self.emptyStateLabel = [UILabel new];
    self.emptyStateLabel.text = [LANG text:@"no_recipes"];
    self.emptyStateLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyStateLabel.textColor = [COLOR text];
    self.emptyStateLabel.font = [FONT fontWithSize:18 withWeight:ATKFontWeightBold];
    [self.view addSubviewAutoLayout:self.emptyStateLabel];
    [self.emptyStateLabel snap];
    self.emptyStateLabel.hidden = YES;
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

- (void)createRefreshControl
{
    //    if (!self.refreshControl) {
    //        self.refreshControl = [[UIRefreshControl alloc] init];
    //        self.refreshControl.translatesAutoresizingMaskIntoConstraints = NO;
    //        [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    //        [self.collectionView addSubview:self.refreshControl];
    //        [self.refreshControl centerX];
    //        [self.refreshControl snapTopConstant:-22];
    //    }
}

#pragma mark - ATKCollectionViewController

- (void)loadData
{
    [[DataManager instance] fetchRecipes:^(NSArray<Recipe *> *recipes) {
        self.recipes = recipes;
        self.emptyStateLabel.hidden = [recipes count] >  0;
        self.collectionView.hidden  = [recipes count] == 0;
        [self refreshCollectionViewContent];
        [self.refreshControl endRefreshing];
    }];
}
     
- (void)extraCollectionViewSetup:(UICollectionView *)collectionView
 {
     [collectionView registerClass:[ReceipeCollectionViewCell class] forCellWithReuseIdentifier:kReceipeCollectionViewCellIdentifier];
 }

- (UICollectionViewLayout *)layout
{
    return [[UICollectionViewFlowLayout alloc] init];
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
//    Recipe *recipe = self.recipes[indexPath.row];
//    RecipeViewController *recipeViewController = [[RecipeViewController alloc] initWithRecipe:recipe];
//    [self presentViewController:recipeViewController animated:YES completion:nil];

     RecipePagesViewController *recipesVC = [[RecipePagesViewController alloc] initWithRecipes:self.recipes startIndex:indexPath.row];
     [self presentViewController:recipesVC animated:YES completion:nil];

}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([SETTING isIphone]) {
        CGFloat width       = (collectionView.frame.size.width - 3 * 16) / 2;
//        CGFloat pictheight  = width / 1.5f;
//        CGFloat textHeight  = 34.f;
//        CGFloat height      = pictheight + textHeight;
        
        return CGSizeMake(width, width/1.2);
        
    } else {
        
        CGFloat width       = 220.f;//(collectionView.frame.size.width - 3 * 16) / 2;
//        CGFloat pictheight  = width / 1.5f;
//        CGFloat textHeight  = 34.f;
//        CGFloat height      = pictheight + textHeight;
        
        return CGSizeMake(width, width / 1.2);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat margin = [SETTING isIphone] ? 16.f : 20.f;
    return UIEdgeInsetsMake(margin, margin, margin, margin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGFloat spacing = [SETTING isIphone] ? 16.f : 20.f;
    return spacing;
}

@end
