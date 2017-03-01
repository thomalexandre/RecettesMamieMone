//
//  TitleContentTableViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "TitleContentTableViewCell.h"
#import "UIView+Layout.h"
#import "ThemeManager.h"

@interface TitleContentTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TitleContentTableViewCell

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
    
    UIView * line = [UIView new];
    line.backgroundColor = [[ThemeManager instance] line];
    [self addSubviewAutoLayout:line];
    [line snapTopConstant:0];
    [line snapLeftConstant:20];
    [line snapRightConstant:20];
    [line setHeightConstant:1];
    
    // title ...
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [[ThemeManager instance] mediumFontWithSize:18];
    [self addSubviewAutoLayout:self.titleLabel];
    [self.titleLabel snapTopConstant:20];
    [self.titleLabel snapLeftConstant:10];
    [self.titleLabel snapRightConstant:10];
    [self.titleLabel setHeightConstant:20];
    
    // content ...
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.font = [[ThemeManager instance] mediumFontWithSize:16];
    [self addSubviewAutoLayout:self.contentLabel];
    [self.contentLabel snapBottomConstant:20];
    [self.contentLabel snapLeftConstant:15];
    [self.contentLabel snapRightConstant:15];
    
    [self.contentLabel snapTopToBottom:20 relativeToView:self.titleLabel];
}

- (void)setup:(Recipe *)recipe type:(RecipeContentType)type
{
    switch (type) {
        case RecipeContentTypeIngredients:
            self.titleLabel.text = @"Ingrédients";
            self.contentLabel.text = recipe.ingredients;
            break;
            
        case RecipeContentTypePreparation:
            self.titleLabel.text = @"Préparation";
            self.contentLabel.text = recipe.preparation;
            break;
    }
}


@end
