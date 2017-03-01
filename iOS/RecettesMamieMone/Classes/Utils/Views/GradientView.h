//
//  GradientView.h
//  VIKI
//
//  Created by Alexandre Thomas on 1/10/17.
//  Copyright © 2016 athomas. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, GradientDirection) {
    GradientTopDown,
    GradientDownTop,
};

@interface GradientView : UIView
    
- (instancetype)init:(GradientDirection)direction;
    
@end
