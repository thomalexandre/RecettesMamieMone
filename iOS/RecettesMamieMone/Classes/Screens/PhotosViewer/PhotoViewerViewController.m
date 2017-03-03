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

@interface PhotoViewerViewController ()

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
    
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor clearColor];
    [self.view addSubviewAutoLayout:self.imageView];
    [self.imageView snap];
    Photo *photo = self.recipe.photos[self.photoIndex];
    [[StorageManager instance] setImage:self.imageView path:[photo path]];
    
    // gradient ...
    GradientView *gradient = [[GradientView alloc] init:GradientDownTop];
    [self.view addSubviewAutoLayout:gradient];
    [gradient snapTop];
    [gradient snapLeft];
    [gradient snapRight];
    [gradient setHeightConstant:64];
    
    // close button ...
    static int closeButtonImageSize = 18.f;
    static int closeButtonImageTop  = 32.f;
    static int closeButtonImageLeft = 17.f;
    static int closeButtonSize      = 44.f;
    
    UIImageView *closeButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-close"]];
    [closeButtonImage setTintColor:[UIColor whiteColor]];
    [self.view addSubviewAutoLayout:closeButtonImage];
    [closeButtonImage setHeightConstant:closeButtonImageSize];
    [closeButtonImage setWidthConstant:closeButtonImageSize];
    [closeButtonImage snapTopConstant:closeButtonImageTop];
    [closeButtonImage snapLeftConstant:closeButtonImageLeft];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self action:@selector(closeButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubviewAutoLayout:closeButton];
    [closeButton setHeightConstant:closeButtonSize];
    [closeButton setWidthConstant:closeButtonSize];
    [closeButton snapTopConstant:closeButtonImageTop - (closeButtonSize - closeButtonImageSize) / 2.f];
    [closeButton snapLeftConstant:closeButtonImageLeft - (closeButtonSize - closeButtonImageSize) / 2.f];
}

- (void)closeButtonDidPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
