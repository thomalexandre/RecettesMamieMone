//
//  RecipeViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/17/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeViewController.h"
#import "UIView+Layout.h"

@interface RecipeViewController () <UITableViewDelegate, UITableViewDataSource>

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
}

- (void)setupTableView
{
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubviewAutoLayout:self.tableView];
    [self.tableView snap];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = indexPath.row == 0 ? self.recipe.title : indexPath.row == 1 ? self.recipe.ingredients : self.recipe.preparation;
    UIFont   *font = indexPath.row == 0 ? [UIFont boldSystemFontOfSize:18] : [UIFont systemFontOfSize:14];
    
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = text;
    cell.textLabel.font = font;
    
    return cell;
}

@end
