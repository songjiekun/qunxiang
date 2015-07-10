//
//  DoubleTableView.h
//  DoubleTableViewDemo
//
//  Created by song jiekun on 15/7/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DoubleTableViewDelegate <NSObject>

//将选择的项目传递给代理
-(void)selectRowAtDetailIndexPath:(NSIndexPath *)detailIndexPath andMasterIndexPath:(NSIndexPath *)masterIndexPath;

@end
IB_DESIGNABLE
@interface  DoubleTableView : UIView <UITableViewDataSource,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *masterTableView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@property (strong, nonatomic) NSArray *masterArray;
@property (strong, nonatomic) NSArray *detailArrayArray;

@property (nonatomic,weak) id <DoubleTableViewDelegate> delegate;

@end
