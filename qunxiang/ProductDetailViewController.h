//
//  ProductDetailViewController.h
//  qunxiang
//
//  Created by song jiekun on 15/6/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductMore.h"
#import "ImageWithCacheMore.h"

@interface ProductDetailViewController : UIViewController<UIScrollViewDelegate,ImageWithCacheMoreDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *productCategory;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIScrollView *productScrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *outerContentView;
@property (weak, nonatomic) IBOutlet UICollectionView *testCollectionView;


@property (strong, nonatomic) ProductMore *product;
@property (strong, nonatomic) NSCache *imageCache;
@property (strong, nonatomic) NSArray *pageImages;
@property (nonatomic) NSInteger pageWidth;
@property (nonatomic,strong) NSMutableArray *pageViews;
@property (strong, nonatomic) NSOperationQueue *ioQueue;
@property (strong, nonatomic) NSOperationQueue *internetQueue;

@end
