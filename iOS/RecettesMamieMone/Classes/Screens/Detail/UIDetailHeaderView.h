//
//  UIDetailHeaderView.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

#define kBorderDentelHeight 10.f

@protocol UIDetailHeaderViewDelegate <NSObject>

- (void)headerDidClose;

@optional
- (void)headerDidShare;

@end

@interface UIDetailHeaderView : UIView

@property (nonatomic, weak) id<UIDetailHeaderViewDelegate> delegate;

- (instancetype)initWithShare:(BOOL)share;

- (void)showTopBar:(BOOL)showBar showText:(BOOL)showText recipe:(Recipe *)recipe;

- (void)updateGradientAlpha:(CGFloat)alpha;

- (void)makeDisappear;

@end
