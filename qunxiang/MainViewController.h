//
//  MainViewController.h
//  qunxiang
//
//  Created by song jiekun on 15/6/5.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) IBOutlet UIButton *productlistButton;
@property (weak, nonatomic) IBOutlet UIButton *categorylistButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *discusslistButton;
@property (weak, nonatomic) IBOutlet UIButton *profileButton;

@end
