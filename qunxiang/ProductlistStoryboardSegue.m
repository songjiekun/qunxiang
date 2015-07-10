//
//  ProductlistStoryboardSegue.m
//  qunxiang
//
//  Created by song jiekun on 15/6/5.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductlistStoryboardSegue.h"
#import "MainViewController.h"
#import "ProductListTableViewController.h"

@implementation ProductlistStoryboardSegue

- (void) perform {
    
    MainViewController *src = (MainViewController *)self.sourceViewController;
    ProductListTableViewController *dst = (ProductListTableViewController *) self.destinationViewController;
    
    
    
    if (src.currentViewController!=nil) {
        
        [src.currentViewController willMoveToParentViewController:nil];
        [src.currentViewController.view removeFromSuperview];
        [src.currentViewController removeFromParentViewController];
        
    }
    
    UIView *view=dst.view;
    src.currentViewController=dst;
    [src addChildViewController:dst];
    [src.placeholderView addSubview:view];
    [dst didMoveToParentViewController:src];
    
    view.translatesAutoresizingMaskIntoConstraints=NO;
    [src.placeholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    [src.placeholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    
}

@end
