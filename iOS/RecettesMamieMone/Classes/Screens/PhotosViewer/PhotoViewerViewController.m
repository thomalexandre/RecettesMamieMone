//
//  PhotoViewerViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 3/3/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "PhotoViewerViewController.h"
#import "UIViewController+Utils.h"
#import "UIView+Layout.h"
#import "GradientView.h"
#import "UIView+Utils.h"
#import "StorageManager.h"
#import "UIDetailHeaderView.h"
#import "PhotoCollectionViewCell.h"
#import "ATKApp.h"

@interface PhotoViewerViewController () <UIDetailHeaderViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, assign) NSUInteger photoIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraint;

@end

@implementation PhotoViewerViewController

- (instancetype)initWithRecipe:(Recipe *)recipe withPhotoIndex:(NSUInteger)photoIndex
{
    self = [super init];
    if(self) {
        self.recipe = recipe;
        self.photoIndex = photoIndex;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [COLOR text];

    // image carousel ...
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView setDataSource:self];
    [self.collectionView setDelegate:self];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView setPagingEnabled:YES];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:kPhotoCollectionViewCellIdentifier];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.view addSubviewAutoLayout:self.collectionView];
    self.topConstraint = [self.collectionView snapTop];
    [self.collectionView snapBottom];
    [self.collectionView snapLeft];
    [self.collectionView snapRight];
    
    // Navbar ...
    UIDetailHeaderView *header = [UIDetailHeaderView new];
    header.delegate = self;
    [self.view addSubviewAutoLayout:header];
    [header snapTop];
    [header snapRight];
    [header snapLeft];
    [header setHeightConstant:64];
    [header showTopBar:NO showText:YES recipe:self.recipe];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self.view layoutIfNeeded];
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.photoIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)dealloc
{
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}

#pragma mark - UIDetailHeaderViewDelegate

- (void)headerDidClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [cell setup:photo mode:UIViewContentModeScaleAspectFit];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollY = scrollView.contentOffset.y;
//    NSLog(@"%f", scrollY);
    
    if(scrollY > -30) {
        self.topConstraint.constant = scrollY;
    }
    if(scrollY < -100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
