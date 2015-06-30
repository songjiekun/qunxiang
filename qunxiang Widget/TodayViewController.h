//
//  TodayViewController.h
//  qunxiang Widget
//
//  Created by song jiekun on 15/6/17.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *mainProducts;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;

- (IBAction)update:(id)sender;

@end
