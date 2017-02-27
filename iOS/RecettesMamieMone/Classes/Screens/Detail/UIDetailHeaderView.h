//
//  UIDetailHeaderView.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/27/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIDetailHeaderViewDelegate <NSObject>

- (void)headerDidClose;

@end

@interface UIDetailHeaderView : UIView

@property (nonatomic, weak) id<UIDetailHeaderViewDelegate> delegate;
    
@end
