//
//  FiltersViewController.h
//  RecettesMamieMone
//
//  Created by Alexandre Thomas on 2/19/17.
//  Copyright © 2017 MBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersDidApply;

@end

@interface FiltersViewController : UIViewController

@property (nonatomic, weak) id<FiltersViewControllerDelegate> delegate;

- (void)reset;

@end
