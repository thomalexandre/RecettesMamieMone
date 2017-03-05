//
//  FilterHardnessView.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/5/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "FilterHardnessView.h"
#import "UIView+Layout.h"
#import "DataManager.h"
#import "ThemeManager.h"
#import "SelectorCell.h"

@interface FilterHardnessView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FilterHardnessView

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
    return [[DataManager instance].filters numberOfHardnesses];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Hardness *hardness = [[DataManager instance].filters hardnessAtIndex:indexPath.row];
    SelectorCell *cell = (SelectorCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kSelectorCellIdentifier forIndexPath:indexPath];
    [cell setupWithHardness:hardness];
    
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
    [[DataManager instance].filters selectDeselectHardnessAtIndex:indexPath.row];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 37);
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
