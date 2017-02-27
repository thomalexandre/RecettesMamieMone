//
//  RecipeViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/17/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeViewController.h"
#import "UIView+Layout.h"
#import "DataManager.h"
#import "HeroImageTableViewCell.h"
#import "UIDetailHeaderView.h"

@interface RecipeViewController () <UITableViewDelegate, UITableViewDataSource, UIDetailHeaderViewDelegate>

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, strong) UITableView *tableView;

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.recipe.title;
    [self setupTableView];
    [self setupHeader];
    [self reloadData];
}

- (void)setupTableView
{
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubviewAutoLayout:self.tableView];
    [self.tableView snap];
    
    // register cells
    [self.tableView registerClass:[HeroImageTableViewCell class] forCellReuseIdentifier:kHeroImageTableViewCellIdentifier];
}

- (void)setupHeader
{
    UIDetailHeaderView *header = [UIDetailHeaderView new];
    header.delegate = self;
    [self.view addSubviewAutoLayout:header];
    [header snapTop];
    [header snapRight];
    [header snapLeft];
    [header setHeightConstant:60];
}

- (void)reloadData
{
    [[DataManager instance] fetchDetails:self.recipe completion:^(Recipe *recipe) {
        
        self.recipe = recipe;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        return [self heroImageCell];
    }
    
    
    NSString *text = indexPath.row == 1 ? self.recipe.title :
                     indexPath.row == 2 ? [NSString stringWithFormat:@"%@ - %@", self.recipe.type.name, self.recipe.hardness.name] :
                     indexPath.row == 3 ? self.recipe.ingredients :
                                          self.recipe.preparation;
    UIFont   *font = indexPath.row == 1 ? [UIFont boldSystemFontOfSize:18] : [UIFont systemFontOfSize:14];
    
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = text;
    cell.textLabel.font = font;
    
    return cell;
}
    
- (UITableViewCell *)heroImageCell
{
    HeroImageTableViewCell *cell = (HeroImageTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kHeroImageTableViewCellIdentifier];
    
    [cell setup:self.recipe];
    
    return cell;
}
    
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(indexPath.row == 0) {
//        return 200;
//    }
//    
//    return 44;
//}

#pragma mark - UIDetailHeaderViewDelegate

- (void)headerDidClose
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
