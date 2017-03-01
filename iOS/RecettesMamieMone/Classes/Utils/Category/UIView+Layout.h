//
//  UIView-Layout.h
//  ATKit_UI
//
//  Created by Alexandre Thomas on 11/02/16.
//  Copyright © 2016 athomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Layout)

- (void) addSubviewAutoLayout:(UIView *)view;
- (void) snap;
- (void) align:(NSArray *)views withProperties:(NSDictionary *)props;

-(NSLayoutConstraint *) centerX;
-(NSLayoutConstraint *) centerY;
-(NSLayoutConstraint *) centerYWithConstant : (float) constant;
-(NSLayoutConstraint *) centerXWithConstant : (float) constant;

-(NSLayoutConstraint *) snapTop;
-(NSLayoutConstraint *) snapLeft;
-(NSLayoutConstraint *) snapRight;
-(NSLayoutConstraint *) snapBottom;

-(NSLayoutConstraint *) snapTop    : (float) percent;
-(NSLayoutConstraint *) snapLeft   : (float) percent;
-(NSLayoutConstraint *) snapRight  : (float) percent;
-(NSLayoutConstraint *) snapBottom : (float) percent;

-(NSLayoutConstraint *) snapTopConstant    : (float) constant;
-(NSLayoutConstraint *) snapLeftConstant   : (float) constant;
-(NSLayoutConstraint *) snapRightConstant  : (float) constant;
-(NSLayoutConstraint *) snapBottomConstant : (float) constant;

-(NSLayoutConstraint *) snapMinTopConstant    : (float) constant;
-(NSLayoutConstraint *) snapMaxTopConstant    : (float) constant;
-(NSLayoutConstraint *) snapMinLeftConstant   : (float) constant;
-(NSLayoutConstraint *) snapMaxLeftConstant   : (float) constant;
-(NSLayoutConstraint *) snapMinRightConstant  : (float) constant;
-(NSLayoutConstraint *) snapMaxRightConstant  : (float) constant;
-(NSLayoutConstraint *) snapMinBottomConstant : (float) constant;
-(NSLayoutConstraint *) snapMaxBottomConstant : (float) constant;

-(NSLayoutConstraint *) setWidthConstant  : (float) constant;
-(NSLayoutConstraint *) setHeightConstant : (float) constant;

-(NSLayoutConstraint *) setWidthPercent  : (float) percent;
-(NSLayoutConstraint *) setHeightPercent : (float) percent;

-(NSLayoutConstraint *) setMinimumWidthPercent  : (float) percent;
-(NSLayoutConstraint *) setMaximumWidthPercent  : (float) percent;
-(NSLayoutConstraint *) setMinimumHeightPercent : (float) percent;
-(NSLayoutConstraint *) setMaximumHeightPercent : (float) percent;

/*! @brief snap view right margin to the left margin of @param view by @param constant pixels (to be used in horizontal arrangements) */
-(NSLayoutConstraint *) snapRightToLeft :(float)constant relativeToView:(UIView *)view;
/*! @brief snap view left margin to the right margin of @param view by @param constant pixels (to be used in horizontal arrangements) */
-(NSLayoutConstraint *) snapLeftToRight :(float)constant relativeToView:(UIView *)view;
/*! @brief snap view bottom margin to top margin of @param view by @param constant pixels (to be used in vertical arrangements) */
-(NSLayoutConstraint *) snapBottomToTop :(float)constant relativeToView:(UIView *)view;
/*! @brief snap view top margin to bottom margin of @param view by @param constant pixels (to be used in vertical arrangements) */
-(NSLayoutConstraint *) snapTopToBottom :(float)constant relativeToView:(UIView *)view;


- (void)removeConstraints;


@end
