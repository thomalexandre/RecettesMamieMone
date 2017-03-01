//
//  FiltersViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()

@end

@implementation FiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Filtres";
    
    [self setupNavBar];
}

- (void)setupNavBar
{
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(closeDidPress)];
    self.navigationItem.leftBarButtonItem = closeButton;
}

#pragma mark - Actions

- (void)closeDidPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
