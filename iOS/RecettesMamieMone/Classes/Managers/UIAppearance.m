//
//  UIAppearance.m
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 1/4/18.
//  Copyright © 2018 MBC. All rights reserved.
//

#import "UIAppearance.h"
#import <UIKit/UIKit.h>
#import "ATKApp.h"

@implementation UIAppearance

- (void)configureNavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:[COLOR primary]];
    [[UINavigationBar appearance] setTintColor:[COLOR uitext]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [COLOR uitext],
                                                            NSFontAttributeName:[FONT fontWithSize:15 withWeight:ATKFontWeightNormal]}];
}

- (void)configureSegmentControl
{
    [[UISegmentedControl appearance] setTintColor:[COLOR primary]];
}

@end
