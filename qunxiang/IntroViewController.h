//
//  IntroViewController.h
//  qunxiang
//
//  Created by song jiekun on 15/6/22.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIScrollView *introScrollView;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image1YConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image2YConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *image3YConstraint;

@end
