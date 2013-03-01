//
//  DetailViewManager.m
//  MultiViewsTest
//
//  Created by Richard Critz on 2/27/13.
//  Copyright (c) 2013 Richard Critz. All rights reserved.
//

#import "DetailViewManager.h"

@interface DetailViewManager ()
@property (strong, nonatomic) UIBarButtonItem *barButtonItem;
@property (strong, nonatomic) UIPopoverController *popoverController;
@end

@implementation DetailViewManager

#pragma mark - property management

- (void)setDetailViewController:(UIViewController<SubstituteableDetailViewController> *)detailViewController
{
    if (_detailViewController) {
        [_detailViewController setMasterViewControllerBarButtonItem:nil];
    }
    _detailViewController = detailViewController;
    [detailViewController setMasterViewControllerBarButtonItem:self.barButtonItem];
    
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

// update the delegate's local copy and update the detail view controller's copy. The detail view controller
// is responsible for figuring out how to display the button within its scene.
- (void)setBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    _barButtonItem = barButtonItem;
    if (self.detailViewController) {
        [self.detailViewController setMasterViewControllerBarButtonItem:barButtonItem];
    }
}


#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    id detail = [svc.viewControllers lastObject];
    return ([detail conformsToProtocol:@protocol(SubstituteableDetailViewController)]) ? UIInterfaceOrientationIsPortrait(orientation) : NO;
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    // The button provided by UISplitViewController has no title and no image. As a result, it will NOT be
    // displayed, regardless of its presence.  It is therefore mandatory that we set either a title or an
    // image here, or in the detail view controller, as appropriate for the application or the button will
    // not appear (an hour plus wasted on figuring this out!)
    barButtonItem.title = @"Photos";
    self.barButtonItem = barButtonItem;
    self.popoverController = pc;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.barButtonItem = nil;
    self.popoverController = nil;
}

@end
