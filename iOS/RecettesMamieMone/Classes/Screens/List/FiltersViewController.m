//
//  FiltersViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "FiltersViewController.h"
#import "ThemeManager.h"

@interface FiltersViewController ()

@end

@implementation FiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Filtres";
    
    [self setupNavBar];
    self.view.backgroundColor = [[ThemeManager instance] background];
}

- (void)setupNavBar
{
    UIImage *image = [UIImage imageNamed:@"close"];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(closeDidPress)];
    self.navigationItem.leftBarButtonItem = closeButton;
}

#pragma mark - Actions

- (void)closeDidPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
