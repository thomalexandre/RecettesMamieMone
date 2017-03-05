//
//  FilterTypeView.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/4/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "FilterTypeView.h"
#import "UIView+Layout.h"
#import "DataManager.h"
#import "ThemeManager.h"
#import "SelectorCell.h"

@interface FilterTypeView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FilterTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [[ThemeManager instance] background];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    
    [self.collectionView registerClass:[SelectorCell class] forCellWithReuseIdentifier:kSelectorCellIdentifier];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.allowsMultipleSelection = YES;
    
    [self addSubviewAutoLayout:self.collectionView];
    [self.collectionView snap];
    
    self.collectionView.layer.borderColor = [[ThemeManager instance] border].CGColor;
    self.collectionView.layer.borderWidth = 1.f;
    self.collectionView.layer.cornerRadius  = 4.0f;
    
    [self.collectionView reloadData];
}

- (void)reset
{
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[DataManager instance].filters numberOfRecipeTypes];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeType *recipeType = [[DataManager instance].filters recipeAtIndex:indexPath.row];
    SelectorCell *cell = (SelectorCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kSelectorCellIdentifier forIndexPath:indexPath];
    [cell setupWithRecipeType:recipeType];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self collectionView:collectionView selectDeselectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self collectionView:collectionView selectDeselectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView selectDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectorCell *cell = (SelectorCell *)[collectionView cellForItemAtIndexPath:indexPath];
    RecipeType *recipeType = [[DataManager instance].filters selectDeselectRecipeAtIndex:indexPath.row];
    [cell setupWithRecipeType:recipeType];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

@end
