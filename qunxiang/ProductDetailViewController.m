//
//  ProductDetailViewController.m
//  qunxiang
//
//  Created by song jiekun on 15/6/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ImageWithCacheMore.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

//@synthesize product;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    //设置界面
    self.productCategory.text=self.product.productCategory;
    self.productDescription.text=self.product.productDescription;
    self.productPrice.text=[self.product.productPrice stringValue];
    
    ImageWithCacheMore *firstImage=(ImageWithCacheMore *)[self.product.images firstObject];
    self.productImage.image=[firstImage retrieveImage:self fromCache:self.imageCache atIOQueue:self.ioQueue atInternetQueue:self.internetQueue] ;
    
    
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

@end
