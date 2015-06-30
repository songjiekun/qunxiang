//
//  TodayViewController.m
//  qunxiang Widget
//
//  Created by song jiekun on 15/6/17.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "ProductMore.h"
#import "ProductTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        //使用leancloud的身份证明
        [AVOSCloud setApplicationId:@"mo5qxlh3d8ccoplwzf5abcusjgdo2f5ti5224e8hplh36x50"
                          clientKey:@"8l5ktvkshzhd64ezfi7btj4fhoiuxg93ne7bkdarfqrbx8zk"];
        //初始化mainProduct
        self.mainProducts=[[NSMutableArray alloc] initWithCapacity:4];
        
        for (NSInteger i = 0; i < 4; ++i) {
            NSNumber *newPrice = [NSNumber numberWithFloat:(11.1+i)];
            ProductMore *newProduct = [ProductMore productOfDescription:@"产品1" category:@"分类1" price:newPrice url:nil createdDate:[NSDate date] updatedDate:[NSDate date] context:nil];
            [self.mainProducts addObject:newProduct];
        }
        
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [self.mainProducts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainProductCell" forIndexPath:indexPath];
    
    Product *product=(self.mainProducts)[indexPath.row];
    
    cell.productCategory.text=product.productCategory;
    cell.productDescription.text=product.productDescription;
    cell.productPrice.text=[product.productPrice stringValue];
    cell.productImage.image=[self resizeImage:product.images withNewSize:CGSizeMake(50, 50)];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - 刷新products列表
- (void)refreshProducts:(NSMutableArray *)reloadedProducts{
    
    /*
    //刷新前的table列表数量
    NSUInteger currentRowCount=self.mainProducts.count;
    
    [self.mainProducts removeAllObjects];
    
    //设置新添加的列表路径
    NSMutableArray *indexPaths=[[NSMutableArray alloc] initWithCapacity:currentRowCount];
    for (int i=0; i<currentRowCount; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    
    //删除列表
    [self.tableview beginUpdates];
    [self.tableview deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableview endUpdates];
    
    
    self.mainProducts=reloadedProducts;
    
    //设置新添加的列表路径
    indexPaths=[[NSMutableArray alloc] initWithCapacity:reloadedProducts.count];
    for (int i=0; i<reloadedProducts.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    
    //插入列表
    [self.tableview beginUpdates];
    [self.tableview insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableview endUpdates];
    */
    
    [self.mainProducts removeAllObjects];
    self.mainProducts=reloadedProducts;
    
    [self.tableview reloadData];
    
    //constraint变长
    self.tableHeightConstraint.constant=500;
    [self.tableview setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:3 animations:^{
        
        [self.tableview layoutIfNeeded];
    }];
    
    
    
}


- (IBAction)update:(id)sender {
    
    [ProductMore reloadProducts:self action:@selector(refreshProducts:) beforeDate:nil context:nil];
    
}


-(UIImage *)resizeImage :(UIImage *)theImage withNewSize:(CGSize)theNewSize {
    UIGraphicsBeginImageContextWithOptions(theNewSize, NO, 1.0);
    [theImage drawInRect:CGRectMake(0, 0, theNewSize.width, theNewSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
