//
//  FiltersViewController.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "FiltersViewController.h"
#import "ThemeManager.h"
#import "UIView+Utils.h"
#import "UIView+Layout.h"

@interface FiltersViewController ()

@end

@implementation FiltersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [[ThemeManager instance] background];
    [self setupShadhow];
    
    [self setupUI];
}

- (void)setupShadhow
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    self.view.layer.masksToBounds = NO;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(-2.0f, 0.0f);
    self.view.layer.shadowOpacity = 0.3f;
    self.view.layer.shadowPath = shadowPath.CGPath;
}

- (void)setupUI
{
    CGFloat margin = 10.f;
    
    UILabel *typeLabel = [UILabel new];
    typeLabel.text = @"Type de plat";
    typeLabel.font = [[ThemeManager instance] openSansRegularFontWithSize:18];
    typeLabel.textColor = [[ThemeManager instance] text];
    [self.view addSubviewAutoLayout:typeLabel];
    [typeLabel snapTopConstant:20];
    [typeLabel snapLeftConstant:margin];
    
    NSArray *typesArray = [NSArray arrayWithObjects: @"entrée", @"plat principal", @"dessert", nil];
    UISegmentedControl *segmentedControlTypes = [[UISegmentedControl alloc] initWithItems:typesArray];
    [self.view addSubviewAutoLayout:segmentedControlTypes];
    [segmentedControlTypes snapLeftConstant:margin];
    [segmentedControlTypes snapRightConstant:margin];
    [segmentedControlTypes snapTopToBottom:10 relativeToView:typeLabel];
    
    UILabel *hardnessLabel = [UILabel new];
    hardnessLabel.text = @"Difficulté";
    hardnessLabel.font = [[ThemeManager instance] openSansRegularFontWithSize:18];
    hardnessLabel.textColor = [[ThemeManager instance] text];
    [self.view addSubviewAutoLayout:hardnessLabel];
    [hardnessLabel snapTopToBottom:20 relativeToView:segmentedControlTypes];
    [hardnessLabel snapLeftConstant:margin];
    
    NSArray *hardnessArray = [NSArray arrayWithObjects: @"facile", @"moyen", @"difficile", nil];
    UISegmentedControl *segmentedControlHardness = [[UISegmentedControl alloc] initWithItems:hardnessArray];
    [self.view addSubviewAutoLayout:segmentedControlHardness];
    [segmentedControlHardness snapLeftConstant:margin];
    [segmentedControlHardness snapRightConstant:margin];
    [segmentedControlHardness snapTopToBottom:10 relativeToView:hardnessLabel];
    

    [self setupBottomText];
}

- (void)setupBottomText
{
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.text = @"Á notre mamie ♥";
    bottomLabel.font = [[ThemeManager instance] merriweatherFontWithSize:14];
    bottomLabel.textColor = [[ThemeManager instance] text];
    [self.view addSubviewAutoLayout:bottomLabel];
    [bottomLabel snapBottomConstant:10];
    [bottomLabel centerX];
}

#pragma mark - Actions

- (void)closeDidPress
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
