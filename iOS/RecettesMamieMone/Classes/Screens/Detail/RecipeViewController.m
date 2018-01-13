//
//  RecipeViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/17/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeViewController.h"
#import "DataManager.h"
#import "HeroImageTableViewCell.h"
#import "RecipeMetadataTableViewCell.h"
#import "TitleContentTableViewCell.h"
#import "PhotosTableViewCell.h"
#import "PhotoViewerViewController.h"

typedef NS_ENUM(NSInteger, RecipeDetailSection) {
    RecipeDetailSectionHeader       = 0,
    RecipeDetailSectionMetadata     = 1,
    RecipeDetailSectionIngredients  = 2,
    RecipeDetailSectionPreparation  = 3,
    RecipeDetailSectionPhotos       = 4,
};

@interface RecipeViewController () <UITableViewDelegate, UITableViewDataSource, UIDetailHeaderViewDelegate, PhotosTableViewCellDelegate, HeroImageTableViewCellDelegate>

@property (nonatomic, strong) Recipe *recipe;
//@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak)   HeroImageTableViewCell *heroCell;
@property (nonatomic, strong) NSArray<NSNumber *>  *sections;

@end

@implementation RecipeViewController

- (instancetype)initWithRecipe:(Recipe *)recipe
{
    self = [super init];
    if(self) {
        self.recipe = recipe;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [COLOR background];
    self.title = self.recipe.title;
}

#pragma mark - ATKTableViewController

- (void)loadData
{
    [[DataManager instance] fetchDetails:self.recipe completion:^(Recipe *recipe) {
        self.recipe = recipe;
        
        /// check available sections
        NSMutableArray<NSNumber *> *sections = [NSMutableArray new];
        [sections addObject:@(RecipeDetailSectionHeader)];
        [sections addObject:@(RecipeDetailSectionMetadata)];
        if([self.recipe.ingredients length] > 0)
            [sections addObject:@(RecipeDetailSectionIngredients)];
        if([self.recipe.preparation length] > 0)
            [sections addObject:@(RecipeDetailSectionPreparation)];
        if([self.recipe.photos count] > 0)
            [sections addObject:@(RecipeDetailSectionPhotos)];
        self.sections = sections;
        
        [self refreshTableViewContent];
    }];
}

- (void)extraTableViewSetup:(UITableView *)tableView
{
    // register cells
    [tableView registerClass:[HeroImageTableViewCell class]      forCellReuseIdentifier:kHeroImageTableViewCellIdentifier];
    [tableView registerClass:[RecipeMetadataTableViewCell class] forCellReuseIdentifier:kRecipeMetadataTableViewCellIdentifier];
    [tableView registerClass:[TitleContentTableViewCell class]   forCellReuseIdentifier:kTitleContentTableViewCellIdentifier];
    [tableView registerClass:[PhotosTableViewCell class]         forCellReuseIdentifier:kPhotosTableViewCellIdentifier];
}

- (void)scrollToTop
{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSInteger count = 4;
//    
//    if([self.recipe.photos count] > 0) {
//        count ++;
//    }
//    
//    return count;

    return [self.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeDetailSection section = [self.sections[indexPath.row] intValue];
    
    switch (section) {
        case RecipeDetailSectionHeader:      return [self heroImageCell]; break;
        case RecipeDetailSectionMetadata:    return [self metadataCell];  break;
        case RecipeDetailSectionIngredients: return [self titleContent:RecipeContentTypeIngredients];  break;
        case RecipeDetailSectionPreparation: return [self titleContent:RecipeContentTypePreparation];  break;
        case RecipeDetailSectionPhotos:      return [self photosCarousel]; break;
    }
}
    
- (UITableViewCell *)heroImageCell
{
    HeroImageTableViewCell *cell = (HeroImageTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kHeroImageTableViewCellIdentifier];
    cell.delegate = self;
    [cell setup:self.recipe];
    self.heroCell = cell;
    return cell;
}

- (UITableViewCell *)metadataCell
{
    RecipeMetadataTableViewCell *cell = (RecipeMetadataTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kRecipeMetadataTableViewCellIdentifier];
    [cell setup:self.recipe];
    return cell;
}

- (UITableViewCell *)titleContent:(RecipeContentType)type
{
    TitleContentTableViewCell *cell = (TitleContentTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kTitleContentTableViewCellIdentifier];
    [cell setup:self.recipe type:type];
    return cell;
}

- (UITableViewCell *)photosCarousel
{
    PhotosTableViewCell *cell = (PhotosTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kPhotosTableViewCellIdentifier];
    cell.delegate = self;
    [cell setup:self.recipe];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateHeaderBasedOnScrolling];
}

- (void)updateHeaderBasedOnScrolling
{
    CGFloat scrollY    = self.tableView.contentOffset.y;
    CGFloat alpha = [self.heroCell viewDidScroll:scrollY];
    BOOL needToShowBar = alpha > 1.f;
    [self.header showTopBar:needToShowBar showText:needToShowBar recipe:self.recipe];
    [self.header updateGradientAlpha:1.f-alpha];
    
    if(scrollY < -125) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIDetailHeaderViewDelegate

- (void)headerDidClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)headerDidShare
{
    int a = 0;
}

#pragma mark - PhotosTableViewCellDelegate

- (void)photoDidTapAtIndex:(NSUInteger)photoIndex
{
    PhotoViewerViewController *viewer = [[PhotoViewerViewController alloc] initWithRecipe:self.recipe withPhotoIndex:photoIndex];
    
    [self presentViewController:viewer animated:YES completion:nil];
}

#pragma mark - HeroImageTableViewCellDelegate

- (void)photoButtonDidSelect
{
    [self photoDidTapAtIndex:0];
}

@end
