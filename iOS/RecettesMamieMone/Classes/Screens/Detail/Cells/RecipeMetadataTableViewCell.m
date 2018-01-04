//
//  RecipeMetadataTableViewCell.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import "RecipeMetadataTableViewCell.h"
#import "UIView+Layout.h"
#import "UIView+Utils.h"
#import "ATKApp.h"

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
    self.typeLabel.textColor = [COLOR primary];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.font = [FONT fontWithSize:12 withWeight:ATKFontWeightBold];
    [self addSubviewAutoLayout:self.typeLabel];
    [self.typeLabel snapTopConstant:10];
    [self.typeLabel snapLeftConstant:10];
    [self.typeLabel snapRightConstant:10];
    [self.typeLabel setHeightConstant:20];
    
    // title ...
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [COLOR text];
    self.titleLabel.font = [FONT fontWithSize:20 withWeight:ATKFontWeightBold];
    [self addSubviewAutoLayout:self.titleLabel];
    [self.titleLabel snapBottomConstant:20];
    [self.titleLabel snapLeftConstant:10];
    [self.titleLabel snapRightConstant:10];
    [self.titleLabel setHeightConstant:25];
    
    [self.titleLabel snapTopToBottom:10 relativeToView:self.typeLabel];
}

- (void)setup:(Recipe *)recipe
{
    NSString *type  = [NSString stringWithFormat:@"%@ - %@", [recipe.type.name uppercaseString],
                                                                  [recipe.hardness.name uppercaseString]];
    if([recipe.persons length] > 0) {
        type = [NSString stringWithFormat:@"%@ - %@", type, [recipe.persons uppercaseString]];
    }
    
    self.typeLabel.text  = type;
    self.titleLabel.text = recipe.title;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.typeLabel.text = nil;
    self.titleLabel.text = nil;
}

@end
