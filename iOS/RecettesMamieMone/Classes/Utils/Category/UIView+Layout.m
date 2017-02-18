//
//  UIView-Layout.m
//  ATKit_UI
//
//  Created by Alexandre Thomas on 11/02/16.
//  Copyright © 2016 athomas. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (void)addSubviewAutoLayout:(UIView *)view
{
    [self addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void) snap
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self snapTop];
    [self snapLeft];
    [self snapBottom];
    [self snapRight];
}

-(NSLayoutConstraint *) snapTop
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeTop;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: 1.0 constant: 0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) snapBottom
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute = NSLayoutAttributeBottom;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: 1.0 constant: 0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) snapRight
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeRight;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: 1.0 constant: 0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) snapLeft
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeLeft;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: 1.0 constant: 0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) snapTopConstant:(float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint =  [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: NSLayoutAttributeTop multiplier: 1.0 constant: constant];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) snapLeftConstant:(float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeLeft;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: 1.0 constant: constant];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) snapRightConstant:(float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual toItem:self.superview attribute: NSLayoutAttributeRight multiplier: 1.0 constant: -constant];
    [self.superview addConstraint:constraint];
 
    return constraint;
}

-(NSLayoutConstraint *) snapBottomConstant:(float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: NSLayoutAttributeBottom multiplier: 1.0 constant: -constant];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) snapMinTopConstant    : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationGreaterThanOrEqual toItem: self.superview attribute: NSLayoutAttributeTop multiplier: 1.0 constant: constant];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) snapMaxTopConstant    : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationLessThanOrEqual toItem: self.superview attribute: NSLayoutAttributeTop multiplier: 1.0 constant: constant];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) snapMinLeftConstant   : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeLeft;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationGreaterThanOrEqual toItem: self.superview attribute: attribute multiplier: 1.0 constant: constant];
    [self.superview addConstraint:constraint];
    
    return constraint;
}

-(NSLayoutConstraint *) snapMaxLeftConstant   : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeLeft;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationLessThanOrEqual toItem: self.superview attribute: attribute multiplier: 1.0 constant: constant];
    [self.superview addConstraint:constraint];
    
    return constraint;
}

-(NSLayoutConstraint *) snapMinRightConstant  : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute: NSLayoutAttributeRight multiplier: 1.0 constant: -constant];
    [self.superview addConstraint:constraint];
    
    return constraint;
}

-(NSLayoutConstraint *) snapMaxRightConstant  : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationLessThanOrEqual toItem:self.superview attribute: NSLayoutAttributeRight multiplier: 1.0 constant: -constant];
    [self.superview addConstraint:constraint];
    
    return constraint;
}

-(NSLayoutConstraint *) snapMinBottomConstant : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationGreaterThanOrEqual toItem: self.superview attribute: NSLayoutAttributeBottom multiplier: 1.0 constant: -constant];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) snapMaxBottomConstant : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationLessThanOrEqual toItem: self.superview attribute: NSLayoutAttributeBottom multiplier: 1.0 constant: -constant];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) snapLeft:(float) percent
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeRight;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeLeft relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: percent/100 constant: 0];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) snapRight:(float) percent
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeRight;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeRight relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: percent/100 constant: 0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) snapTop:(float) percent
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeBottom;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: percent/100 constant: 0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) snapBottom:(float) percent
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutAttribute attribute     = NSLayoutAttributeBottom;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: attribute multiplier: percent/100 constant: 0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) centerX
{
    return [self centerXWithConstant : 0];
}

-(NSLayoutConstraint *) centerY
{
    return [self centerYWithConstant : 0];
}


-(NSLayoutConstraint *) centerXWithConstant : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: NSLayoutAttributeCenterX multiplier: 1.0 constant: constant];
    [self.superview addConstraint: constraint];
    
    return constraint;
}

-(NSLayoutConstraint *) centerYWithConstant : (float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem: self attribute: NSLayoutAttributeCenterY relatedBy: NSLayoutRelationEqual toItem: self.superview attribute: NSLayoutAttributeCenterY multiplier: 1.0 constant: constant];
    [self.superview addConstraint: constraint];
    
    return constraint;
}

//[view setContentHuggingPriority:NSLayoutPriorityRequired forOrientation:NSLayoutConstraintOrientationVertical];

-(void) align:(NSArray *)children withProperties:(NSDictionary *) props
{
    BOOL  samesize   = props[@"samesize"]  ? [props[@"samesize"] boolValue]  : NO;
    float spacing    = props[@"spacing"]   ? [props[@"spacing"] floatValue]  : 0;

    NSString * align = props[@"align"]     ? [props[@"align"] description]   : Nil;
    NSInteger axis   = props[@"direction"] ? [props[@"direction"] longValue] : UILayoutConstraintAxisHorizontal;

    NSMutableString *vfl = [NSMutableString string];
    NSMutableDictionary * views = [NSMutableDictionary dictionary];

    for (int i = 0 ;  i < children.count; i++)
    {
        NSString * viewName = [NSString stringWithFormat:@"v%d", i];
        views[viewName] = children[i];
    }

    NSString *direction = (axis == UILayoutConstraintAxisHorizontal) ? @"H:": @"V:";
    NSDictionary * metrics = @{@"spacing" : @(spacing)};
    [vfl appendString:direction];
    [vfl appendString:@"|"];

    if ([align isEqualToString:@"right"] || [align isEqualToString:@"both"])
    {
        [vfl appendString:@"->=0"];
    }
    else
    {
        [vfl appendString:@"-spacing"];
    }

    for (int i = 0; i < children.count; i++)
    {
        NSString * viewName = [NSString stringWithFormat:@"v%d", i];

        if (i==0 || !samesize)
        {
            [vfl appendFormat:@"-[%@]", viewName];
        }
        else
        {
            [vfl appendFormat:@"-[%@(v0)]", viewName];
        }

        if (([align isEqualToString:@"left"] || [align isEqualToString:@"both"])&& i==children.count-1)
        {
            [vfl appendString:@"->=0"];
        }
        else
        {
            [vfl appendString:@"-spacing"];
        }
    }

    [vfl appendString:@"-|"];

    //NSLog(@"%@", vfl);

    NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:metrics views:views];

    [self addConstraints:constraints];
}

-(NSLayoutConstraint *) setWidthConstant:(float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:constant];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) setHeightConstant:(float) constant
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:constant];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) setWidthPercent: (float) percent
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:percent/100 constant:0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) setHeightPercent: (float) percent
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:percent/100 constant:0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) setMinimumWidthPercent: (float) percent
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:percent/100 constant:0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) setMaximumWidthPercent: (float) percent {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:percent/100 constant:0];
    [self.superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *) setMinimumHeightPercent: (float) percent
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:percent/100 constant:0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(NSLayoutConstraint *) setMaximumHeightPercent: (float) percent
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:percent/100 constant:0];
    [self.superview addConstraint:constraint];

    return constraint;
}

-(void) removeConstraints
{
    NSAssert(self.superview,@"Can't snap to a superview if no superview exists");

    UIView *superview = self.superview;

    while (superview != nil)
    {
        for (NSLayoutConstraint *c in superview.constraints)
        {
            if (c.firstItem == self || c.secondItem == self)
            {
                [superview removeConstraint:c];
            }
        }

        superview = superview.superview;
    }

    //[self removeConstraints:self.constraints];
    //self.translatesAutoresizingMaskIntoConstraints = YES;
}

@end
