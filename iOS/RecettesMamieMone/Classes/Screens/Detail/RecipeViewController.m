//
//  RecipeViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/17/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController ()

@property (nonatomic, strong) Recipe *recipe;

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
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.title = self.recipe.title;
}


@end
