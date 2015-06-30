//
//  ProductListTableViewController.h
//  qunxiang
//
//  Created by song jiekun on 15/6/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductMore.h"
#import "ProductTableViewCell.h"
#import "ProductDetailViewController.h"
#import "SVPullToRefresh.h"//不要create folder reference，而是create file group。否则会出错
#import "ImageWithCacheMore.h"


@interface ProductListTableViewController : UITableViewController <ImageWithCacheMoreDelegate>

@property (strong, nonatomic) NSMutableArray *mainProducts;
@property (strong, nonatomic) NSCache *imageCache;
@property (strong, nonatomic) NSOperationQueue *ioQueue;
@property (strong, nonatomic) NSOperationQueue *internetQueue;
@property (strong, nonatomic) NSDate *lastProductDate;


@end
