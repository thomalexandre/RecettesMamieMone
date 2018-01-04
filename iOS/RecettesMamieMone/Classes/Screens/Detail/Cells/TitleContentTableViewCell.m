//
//  TitleContentTableViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "TitleContentTableViewCell.h"
#import "UIView+Layout.h"
#import "UIView+Utils.h"
#import "ATKApp.h"

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
    CGFloat margin = [SETTING isIphone] ? 15 : 40;
    
    UIView * line = [UIView new];
    line.backgroundColor = [COLOR ui];
    [self addSubviewAutoLayout:line];
    [line snapTopConstant:0];
    [line snapLeftConstant:margin];
    [line snapRightConstant:margin];
    [line setHeightConstant:1];
    
    // title ...
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [FONT fontWithSize:18 withWeight:ATKFontWeightBold];
    self.titleLabel.textColor = [COLOR primary];
    [self addSubviewAutoLayout:self.titleLabel];
    [self.titleLabel snapTopConstant:30];
    [self.titleLabel snapLeftConstant:10];
    [self.titleLabel snapRightConstant:10];
    [self.titleLabel setHeightConstant:25];
    
    // content ...
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = [COLOR text];
//    self.contentLabel.font = ;
    [self addSubviewAutoLayout:self.contentLabel];
    [self.contentLabel snapBottomConstant:30];
    [self.contentLabel snapLeftConstant:margin];
    [self.contentLabel snapRightConstant:margin];
    
    [self.contentLabel snapTopToBottom:30 relativeToView:self.titleLabel];
}

- (void)setup:(Recipe *)recipe type:(RecipeContentType)type
{
    switch (type) {
        case RecipeContentTypeIngredients:
            self.titleLabel.text = @"Ingrédients";
            [self contentText:recipe.ingredients];
            break;
            
        case RecipeContentTypePreparation:
            self.titleLabel.text = @"Préparation";
            [self contentText:recipe.preparation];
            break;
    }
}

- (void)contentText:(NSString *)text
{
    if(!text) {
        self.contentLabel.text = nil;
        return;
    }
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 28.f;
    style.maximumLineHeight = 28.f;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style,
                                  NSFontAttributeName: [FONT fontWithSize:16 withWeight:ATKFontWeightText]};
    self.contentLabel.attributedText = [[NSAttributedString alloc] initWithString:text
                                                             attributes:attributtes];
    [self.contentLabel sizeToFit];
}


@end
