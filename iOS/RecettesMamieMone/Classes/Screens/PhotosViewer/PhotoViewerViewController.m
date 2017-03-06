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
#import "StorageManager.h"
#import "ThemeManager.h"
#import "UIDetailHeaderView.h"
#import "iCarousel.h"

@interface PhotoViewerViewController () <UIDetailHeaderViewDelegate, iCarouselDataSource>

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, assign) NSUInteger photoIndex;
@property (nonatomic, strong) iCarousel *carousel;

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
    
    self.view.backgroundColor = [[ThemeManager instance] backgroundPhoto];

    // image carouse
    self.carousel = [iCarousel new];
    self.carousel.pagingEnabled = YES;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.stopAtItemBoundary = NO;
    self.carousel.backgroundColor = [[ThemeManager instance] backgroundPhoto];
    self.carousel.dataSource = self;
    [self.view addSubviewAutoLayout:self.carousel];
    [self.carousel snap];
    
    // Navbar
    UIDetailHeaderView *header = [UIDetailHeaderView new];
    header.delegate = self;
    [self.view addSubviewAutoLayout:header];
    [header snapTop];
    [header snapRight];
    [header snapLeft];
    [header setHeightConstant:64];
    [header showTopBar:NO showText:YES recipe:self.recipe];
}

- (void)dealloc
{
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
}

#pragma mark - UIDetailHeaderViewDelegate

- (void)headerDidClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.recipe.photos count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    UIView *v = [[UIView alloc] initWithFrame:self.view.frame];
    v.backgroundColor = [UIColor clearColor];
    UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-10, self.view.frame.size.height-10)];
    [v addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    Photo *photo = self.recipe.photos[index];
    [[StorageManager instance] setImage:imageView path:[photo path]];
    return v;
}

@end
