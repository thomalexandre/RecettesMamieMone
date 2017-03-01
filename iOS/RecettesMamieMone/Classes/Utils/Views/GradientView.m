//
//  GradientView.h
//  VIKI
//
//  Created by Alexandre Thomas on 1/10/17.
//  Copyright © 2016 athomas. All rights reserved.
//

#import "GradientView.h"

@interface GradientView ()

@property (nonatomic, strong) CAGradientLayer *gradient;

@end

@implementation GradientView

- (instancetype)init
{
    return [self init:GradientTopDown];
}
    
- (instancetype)init:(GradientDirection)direction
{
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.gradient = [CAGradientLayer layer];
        
        switch (direction) {
            case GradientTopDown:
            self.gradient.colors = @[(id)[[UIColor clearColor] CGColor],
                                     (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] CGColor]];
            break;
            
            case GradientDownTop:
            self.gradient.colors = @[(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] CGColor],
                                     (id)[[UIColor clearColor] CGColor]];
            break;
        }
        
        [self.layer insertSublayer:self.gradient atIndex:0];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.gradient.frame = rect;
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
    self.gradient.frame = self.bounds;
}

@end
