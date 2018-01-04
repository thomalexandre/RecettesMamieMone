//
//  FilterSelectorView.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/6/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "FilterSelectorView.h"
#import "UIView+Layout.h"
#import "UIView+Utils.h"
#import "DataManager.h"
#import "ThemeManager.h"
#import "SelectorCell.h"

@interface FilterSelectorView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FilterSelectorView

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
    @throw [[NSException alloc] initWithName:@"FilterSelectorView" reason:@"please overwrite function in your class" userInfo:@{}];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    @throw [[NSException alloc] initWithName:@"FilterSelectorView" reason:@"please overwrite function in your class" userInfo:@{}];
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
    @throw [[NSException alloc] initWithName:@"FilterSelectorView" reason:@"please overwrite function in your class" userInfo:@{}];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     @throw [[NSException alloc] initWithName:@"FilterSelectorView" reason:@"please overwrite function in your class" userInfo:@{}];
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

#pragma mark - FilterTypeView

@implementation FilterTypeView

- (void)collectionView:(UICollectionView *)collectionView selectDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectorCell *cell = (SelectorCell *)[collectionView cellForItemAtIndexPath:indexPath];
    RecipeType *recipeType = [[DataManager instance].filters selectDeselectRecipeAtIndex:indexPath.row];
    [cell setupWithRecipeType:recipeType];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 90);
}

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

@end

#pragma mark - FilterHardnessView

@implementation FilterHardnessView

- (void)collectionView:(UICollectionView *)collectionView selectDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[DataManager instance].filters selectDeselectHardnessAtIndex:indexPath.row];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 37);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[DataManager instance].filters numberOfHardnesses];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Hardness *hardness = [[DataManager instance].filters hardnessAtIndex:indexPath.row];
    SelectorCell *cell = (SelectorCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kSelectorCellIdentifier forIndexPath:indexPath];
    [cell setupWithHardness:hardness];
    
    return cell;
}

@end
