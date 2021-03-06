//
//  PhotosTableViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/28/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "PhotosTableViewCell.h"
#import "PhotoCollectionViewCell.h"


@interface PhotosTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) Recipe *recipe;
@end

@implementation PhotosTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView * line = [UIView new];
    line.backgroundColor = [COLOR ui];
    [self addSubviewAutoLayout:line];
    [line snapTopConstant:0];
    [line snapLeftConstant:20];
    [line snapRightConstant:20];
    [line setHeightConstant:1];
    
    // title ...
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = [LANG text:@"recipe_photos"];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [COLOR primary];
    titleLabel.font = [FONT fontWithSize:20 withWeight:ATKFontWeightBold];
    [self addSubviewAutoLayout:titleLabel];
    [titleLabel snapTopConstant:20];
    [titleLabel snapLeftConstant:10];
    [titleLabel snapRightConstant:10];
    [titleLabel setHeightConstant:20];
    
    //collection view ...
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:kPhotoCollectionViewCellIdentifier];
    
    [self addSubviewAutoLayout:self.collectionView];
    [self.collectionView snapBottom];
    [self.collectionView snapLeft];
    [self.collectionView snapRight];
    [self.collectionView setHeightConstant:180];
    
    [self.collectionView snapTopToBottom:20 relativeToView:titleLabel];
}

- (void)setup:(Recipe *)recipe
{
    self.recipe = recipe;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.recipe.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCollectionViewCellIdentifier forIndexPath:indexPath];
    Photo *photo = self.recipe.photos[indexPath.row];
    [cell setup:photo mode:UIViewContentModeScaleAspectFill];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(photoDidTapAtIndex:)]) {
        [self.delegate photoDidTapAtIndex:indexPath.row];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 150);
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
