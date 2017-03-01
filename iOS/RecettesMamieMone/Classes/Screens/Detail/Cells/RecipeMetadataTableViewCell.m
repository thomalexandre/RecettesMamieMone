//
//  RecipeMetadataTableViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeMetadataTableViewCell.h"
#import "UIView+Layout.h"
#import "ThemeManager.h"

@interface RecipeMetadataTableViewCell ()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation RecipeMetadataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // type ...
    self.typeLabel = [UILabel new];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.font = [[ThemeManager instance] mediumFontWithSize:12];
    [self addSubviewAutoLayout:self.typeLabel];
    [self.typeLabel snapTopConstant:10];
    [self.typeLabel snapLeftConstant:10];
    [self.typeLabel snapRightConstant:10];
    [self.typeLabel setHeightConstant:20];
    
    // title ...
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [[ThemeManager instance] mediumFontWithSize:20];
    [self addSubviewAutoLayout:self.titleLabel];
    [self.titleLabel snapBottomConstant:20];
    [self.titleLabel snapLeftConstant:10];
    [self.titleLabel snapRightConstant:10];
    [self.titleLabel setHeightConstant:20];
    
    [self.titleLabel snapTopToBottom:10 relativeToView:self.typeLabel];
}

- (void)setup:(Recipe *)recipe
{
    self.typeLabel.text  = [NSString stringWithFormat:@"%@ - %@", [recipe.type.name uppercaseString], [recipe.hardness.name uppercaseString]] ;
    self.titleLabel.text = recipe.title;
}

- (void)prepareForReuse
{
    self.typeLabel.text = nil;
    self.titleLabel.text = nil;
}

@end
