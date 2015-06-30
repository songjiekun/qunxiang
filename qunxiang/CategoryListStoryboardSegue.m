//
//  CategoryListStoryboardSegue.m
//  qunxiang
//
//  Created by song jiekun on 15/6/5.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "CategoryListStoryboardSegue.h"
#import "MainViewController.h"
#import "CategoryListTableViewController.h"

@implementation CategoryListStoryboardSegue

- (void) perform {
    
    MainViewController *src = (MainViewController *)self.sourceViewController;
    CategoryListTableViewController *dst = (CategoryListTableViewController *) self.destinationViewController;
    
    
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
