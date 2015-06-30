//
//  IntroViewController.m
//  qunxiang
//
//  Created by song jiekun on 15/6/22.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    
    
    self.pageControl.currentPage=0;
    self.pageControl.numberOfPages=3;
    self.introScrollView.contentSize = CGSizeMake(self.introScrollView.frame.size.width * 3, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //设置pagecontrol
    CGPoint offset=self.introScrollView.contentOffset;
    CGFloat pageWidth = self.introScrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((offset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    self.pageControl.currentPage=page;
    
    //动态效果
    CGRect viewFram = self.view.frame;
    CGRect introScrollViewFram = self.introScrollView.frame;

    
    if (page==0) {
        
        //[self.image1 layoutIfNeeded];
        CGRect image1Fram = self.image1.frame;
        image1Fram.origin.y=image1Fram.origin.y+(viewFram.size.height/2)*(offset.x/pageWidth);
        CGRect image2Fram = self.image2.frame;
        image2Fram.origin.y=image2Fram.origin.y+(viewFram.size.height/2)*(offset.x/pageWidth);
        
        self.image1YConstraint.constant=172 + (viewFram.size.height)*(offset.x/pageWidth);
        self.image2YConstraint.constant=-250 + (viewFram.size.height)*(offset.x/pageWidth);
        
        self.image1.alpha=1-2*(offset.x/pageWidth);
        
    }
    if (page==2) {
        
        self.confirmButton.alpha=1;
        
    }
    
}

@end
