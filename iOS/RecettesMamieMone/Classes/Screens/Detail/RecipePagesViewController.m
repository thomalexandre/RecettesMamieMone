//
//  RecipePagesViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 5/31/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipePagesViewController.h"
#import "RecipeViewController.h"
#import "UIDetailHeaderView.h"

@interface RecipePagesViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIDetailHeaderViewDelegate>

@property (nonatomic, strong) NSArray<Recipe *> *recipes;
@property (nonatomic, strong) Recipe *currentRecipe;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) UIDetailHeaderView *header;

@end

@implementation RecipePagesViewController

- (instancetype)initWithRecipes:(NSArray<Recipe *> *)recipes startIndex:(NSInteger)startIndex
{
    self = [super init];
    if(self) {
        self.recipes = recipes;
        self.startIndex = startIndex;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [COLOR background];
    
    [self setupPageViewController];
    [self setupHeader];
    
    //setup initial view controller
    RecipeViewController *recipeVC = [self viewControllerAtIndex:self.startIndex];
    [self.pageVC setViewControllers:@[recipeVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)setupPageViewController
{
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                options:nil];
    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    [self.pageVC didMoveToParentViewController:self];
    [self.pageVC.view snap];
    self.pageVC.dataSource = self;
    self.pageVC.delegate = self;
    
    self.pageVC.view.backgroundColor = [COLOR background];
}

- (void)setupHeader
{
    self.header = [[UIDetailHeaderView alloc] initWithShare:NO];
    self.header.delegate = self;
    [self.view addSubviewAutoLayout:self.header];
    [self.header snapTop];
    [self.header snapRight];
    [self.header snapLeft];
    [self.header setHeightConstant:([SETTING isIphoneX] ? 88 :64) + kBorderDentelHeight];
}

#pragma mark - UIPageViewControllerDelegate


// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    
    [self.header makeDisappear];

    
    
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //
    RecipeViewController *nextController = (RecipeViewController *)[pageViewController.viewControllers lastObject];
    RecipeViewController *prevController = (RecipeViewController *)[previousViewControllers lastObject];
    
    if(prevController.pageIndex != nextController.pageIndex) {
        [prevController scrollToTop];
    } else {
        [prevController updateHeaderBasedOnScrolling];
    }
    
    
//    [self.header showTopBar:NO showText:NO recipe:nil];
//    [self.header updateGradientAlpha:1.f];
}

#pragma mark - UIPageViewDatasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((RecipeViewController*) viewController).pageIndex;
    if((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index --;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((RecipeViewController*) viewController).pageIndex;
    if(index == NSNotFound) {
        return nil;
    }
    index++;
    if(index == [self.recipes count])
    {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (RecipeViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.recipes count] == 0) || (index >= [self.recipes count])) {
        return nil;
    }
    Recipe *recipe = self.recipes[index];
    self.currentRecipe = recipe;
    
    RecipeViewController *recipeViewController = [[RecipeViewController alloc] initWithRecipe:recipe];
    recipeViewController.pageIndex = index;
    recipeViewController.header = self.header;
    return recipeViewController;
}

#pragma mark - UIDetailHeaderViewDelegate

- (void)headerDidClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)headerDidShare
{
//    if(self.currentRecipe.photos.count > 0) {
//        // Need to fetch image and share it along
//    }
//    else {
        [self shareWithImage:nil];
//    }
}

- (void)shareWithImage:(UIImage *)image
{
    NSString *recipeToShare = [NSString stringWithFormat:@"%@\n\n%@\n%@\n\n%@\n%@",
                               self.currentRecipe.title,
                               [LANG text:@"recipe_ingredients"],
                               self.currentRecipe.ingredients,
                               [LANG text:@"recipe_preparation"],
                               self.currentRecipe.preparation];
    
    NSMutableArray *objectsToShare = [@[recipeToShare] mutableCopy];
    if(image) {
        [objectsToShare addObject:image];
    }
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
