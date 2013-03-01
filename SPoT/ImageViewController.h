//
//  ImageViewController.h
//  Shutterbug
//
//  Created by Tatiana Kornilova on 2/22/13.
//  Copyright (c) 2013 Tatiana Kornilova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewManager.h"

@interface ImageViewController :  UIViewController <SubstituteableDetailViewController>
@property (weak, nonatomic) UIBarButtonItem *masterViewControllerBarButtonItem;
@property (nonatomic,strong) NSURL *imageURL;

@end
