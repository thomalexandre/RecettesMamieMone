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
#import "FilterTypeView.h"
#import "FilterHardnessView.h"
#import "DataManager.h"
#import "ConfigurationManager.h"

#define kMarginSection 25.f
#define kMarginTitleContent 15.f

@interface FiltersViewController ()

@property (nonatomic, strong) FilterTypeView     *typeView;
@property (nonatomic, strong) FilterHardnessView *hardnessView;

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
    
    /// Recipe type
    UILabel *typeLabel = [UILabel new];
    typeLabel.text = @"Type de plat";
    typeLabel.font = [[ThemeManager instance] openSansRegularFontWithSize:18];
    typeLabel.textColor = [[ThemeManager instance] text];
    [self.view addSubviewAutoLayout:typeLabel];
    [typeLabel snapTopConstant:kMarginSection];
    [typeLabel snapLeftConstant:margin];
    
    /// recipe type ...
    self.typeView = [FilterTypeView new];
    [self.view addSubviewAutoLayout:self.typeView];
    [self.typeView snapTopToBottom:kMarginTitleContent relativeToView:typeLabel];
    [self.typeView centerX];
    [self.typeView setWidthConstant:270];
    [self.typeView setHeightConstant:90];

    /// Hardness title ....
    UILabel *hardnessLabel = [UILabel new];
    hardnessLabel.text = @"Difficulté";
    hardnessLabel.font = [[ThemeManager instance] openSansRegularFontWithSize:18.f];
    hardnessLabel.textColor = [[ThemeManager instance] text];
    [self.view addSubviewAutoLayout:hardnessLabel];
    [hardnessLabel snapTopToBottom:kMarginSection relativeToView:self.typeView];
    [hardnessLabel snapLeftConstant:margin];

    /// Hardness selector ...
    self.hardnessView = [FilterHardnessView new];
    [self.view addSubviewAutoLayout:self.hardnessView];
    [self.hardnessView snapTopToBottom:kMarginTitleContent relativeToView:hardnessLabel];
    [self.hardnessView centerX];
    [self.hardnessView setWidthConstant:270.f];
    [self.hardnessView setHeightConstant:37.f];
    
    /// Apply button ...
    UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyButton setTitle:@"Appliquer" forState:UIControlStateNormal];
    applyButton.titleLabel.font = [[ThemeManager instance] openSansRegularFontWithSize:14.f];
    applyButton.titleLabel.textColor = [[ThemeManager instance] textButton];
    applyButton.backgroundColor =  [[ThemeManager instance] backgroundButton];
    static CGFloat buttonHeight = 44.f;
    applyButton.layer.cornerRadius = buttonHeight / 2.f;
    [self.view addSubviewAutoLayout:applyButton];
//    [applyButton setWidthConstant:270.f];
    [applyButton setHeightConstant:buttonHeight];
//    [applyButton centerX];
    [applyButton snapLeftConstant:margin];
    [applyButton snapRightConstant:margin];
    [applyButton snapTopToBottom:(kMarginSection * 2.f) relativeToView:self.hardnessView];
    [applyButton addTarget:self action:@selector(applyFilters) forControlEvents:UIControlEventTouchUpInside];

    [self setupBottomText];
}

- (void)setupBottomText
{
    UILabel *bottomLabel = [UILabel new];
    bottomLabel.numberOfLines = 0;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.text = [NSString stringWithFormat:@"Á notre mamie ♥\nv %@", [ConfigurationManager appVersion]];
    bottomLabel.font = [[ThemeManager instance] openSansBoldFontWithSize:14];
    bottomLabel.textColor = [[ThemeManager instance] text];
    [self.view addSubviewAutoLayout:bottomLabel];
    [bottomLabel snapBottomConstant:10];
    [bottomLabel centerX];
}

- (void)reset
{
    [[DataManager instance].filters reset];
    [self.typeView reset];
    [self.hardnessView reset];
}

#pragma mark - Actions

- (void)applyFilters
{
    [[DataManager instance].filters apply];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(filtersDidApply)]) {
        [self.delegate filtersDidApply];
    }
}

@end
