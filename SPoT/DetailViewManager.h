//
//  DetailViewManager.h
//  MultiViewsTest
//
//  Created by Richard Critz on 2/27/13.
//  Copyright (c) 2013 Richard Critz. All rights reserved.
//

/*
 This protocol should be implemented by any view controller that may end up on screen as the detail
 view controller inside a UISplitViewController.  To implement the protocol, it must do 2 things:
 
 1. Implement a setter for the masterViewControllerBarButtonItem property that correctly displays
    and removes the button on its interface. When the split view controller decides the button
    should not be displayed, it will set the property to nil.
 
 2. Set itself as this delegate's detailViewController in its viewWillAppear: method.  For example:
 
        - (void)viewWillAppear:(BOOL)animated
        {
            [super viewWillAppear:animated];
            if (self.splitViewController) {
                ((DetailViewManager *) self.splitViewController.delegate).detailViewController = self;
            }
        }
 */


#import <Foundation/Foundation.h>

@protocol SubstituteableDetailViewController

@property (nonatomic, weak) UIBarButtonItem *masterViewControllerBarButtonItem;

@end

@interface DetailViewManager : NSObject <UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIViewController<SubstituteableDetailViewController> *detailViewController;

@end
