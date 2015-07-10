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
    
    //设置滑动图片
    self.pageImages = [NSArray arrayWithObjects:firstImage,firstImage,firstImage,firstImage,firstImage,nil];
    
    //设置scroll contentview的长度
    NSLayoutConstraint *contentWidth=[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.outerContentView attribute:NSLayoutAttributeWidth multiplier:5.0 constant:0];
    
    [self.outerContentView addConstraint:contentWidth];
    self.pageWidth=[[UIScreen mainScreen] bounds].size.width;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadVisiblePages];
}

- (void)viewDidLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    self.pageWidth=[[UIScreen mainScreen] bounds].size.width;
    //[self loadVisiblePages];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 在入屏幕中的图片
    [self loadVisiblePages];
}
    
- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // 1
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        // 2
        //CGRect frame = self.productScrollView.bounds;
        NSInteger leading = self.productScrollView.frame.size.width*page;//self.pageWidth* page;//frame.size.width * page;
        
        // 3 创建imageview
        //设置imageWithCache的代理
        ImageWithCacheMore *imageMore=(ImageWithCacheMore *)[self.pageImages objectAtIndex:page];
        imageMore.delegate=self;

        
        UIImage *image=[imageMore retrieveImage:self fromCache:self.imageCache atIOQueue:self.ioQueue atInternetQueue:self.internetQueue];
        
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:image];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:newPageView];
        //必须设置为no
        newPageView.translatesAutoresizingMaskIntoConstraints=NO;
        NSLayoutConstraint *top=[NSLayoutConstraint constraintWithItem:newPageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        
        NSLayoutConstraint *bottom=[NSLayoutConstraint constraintWithItem:newPageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        
        NSLayoutConstraint *left=[NSLayoutConstraint constraintWithItem:newPageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:leading];
        
        NSLayoutConstraint *width=[NSLayoutConstraint constraintWithItem:newPageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.outerContentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        
        
        [self.outerContentView addConstraint:width];
        
        [self.contentView addConstraint:top];
        [self.contentView addConstraint:bottom];
        [self.contentView addConstraint:left];
        
        // 4
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        //pageView=nil;
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}
    
- (void)loadVisiblePages {
    // First, determine which page is currently visible
    [self.productScrollView layoutIfNeeded];
    CGFloat pageWidth = self.productScrollView.frame.size.width;//self.pageWidth;
    NSInteger page = (NSInteger)floor((self.productScrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    // Update the page control
    //self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}




#pragma mark - ImageWithCache的代理
-(void)refreshImage:(ImageWithCache *)sender withImage:(UIImage *)newImage{
    
    
    
    for (ImageWithCache *imageMore in self.pageImages) {
        
        if (imageMore==sender) {
            
            NSInteger imageIndex = [self.pageImages indexOfObject:imageMore];
            
            UIImageView *pageView = (UIImageView *)[self.pageViews objectAtIndex:imageIndex];
            
            if ((NSNull*)pageView != [NSNull null]) {
                
                pageView.image=newImage;
                
                pageView.alpha=0;
                
                
                //图片淡入淡出
                [UIView animateWithDuration:0.3 animations:^{
                    
                    pageView.alpha=1;
                    
                }];
                
                
            }
            
            return;
            
        }
        
    }
    
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
