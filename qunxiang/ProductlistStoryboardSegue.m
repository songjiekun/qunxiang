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
    
    src.currentViewController=dst;
    [src addChildViewController:dst];
    [src.placeholderView addSubview:dst.view];
    [dst didMoveToParentViewController:src];
    
}

@end
