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

@interface PhotoViewerViewController () <UIDetailHeaderViewDelegate>

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, assign) NSUInteger photoIndex;
@property (nonatomic, strong) UIImageView * imageView;

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
    
    // Image
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubviewAutoLayout:self.imageView];
    [self.imageView snap];
    Photo *photo = self.recipe.photos[self.photoIndex];
    [[StorageManager instance] setImage:self.imageView path:[photo path]];
    
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

- (void)headerDidClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
