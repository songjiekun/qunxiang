//
//  DoubleTableView.m
//  DoubleTableViewDemo
//
//  Created by song jiekun on 15/7/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "DoubleTableView.h"

@interface DoubleTableView ()

@property (strong, nonatomic) NSIndexPath *masterSelectedIndexPath;

@end

@implementation DoubleTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        UINib *nib=[UINib nibWithNibName:@"DoubleTableView" bundle:[NSBundle mainBundle]];
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"DoubleTableView" owner:self options:nil];
        
        UIView *nibView= views[0];
        
        [self addSubview:nibView];
        
        nibView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        
        

        //[self.masterTableView registerNib:nib forCellReuseIdentifier:@"MasterCellIdentifier"];
        //[self.masterTableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cell"];
        
    }
    
    return self;
    
}


//让interface builder来调用的
- (id)initWithFrame:(CGRect)frame{
    
    if((self=[super initWithFrame:frame])){
        
        UINib *nib=[UINib nibWithNibName:@"DoubleTableView" bundle:[NSBundle bundleForClass:[self class]]];
        
        NSArray *views = [[NSBundle bundleForClass:[self class]] loadNibNamed:@"DoubleTableView" owner:self options:nil];
        
        UIView *nibView= views[0];
        
        [self addSubview:views[0]];
        
        nibView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        
        
        
        self.masterArray=@[@"足球",@"蓝球",@"足球",@"排球",@"网球",@"羽毛球",@"乒乓球",@"足球",@"蓝球",@"足球"];
        
        self.detailArrayArray=@[
                                                @[@"足球",@"足球",@"足球",@"足球",@"足球",@"足球",@"足球",@"足球",@"足球"],
                                                @[@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球"],
                                                @[@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球"],
                                                @[@"网球",@"网球",@"网球",@"网球",@"网球",@"网球",@"网球",@"网球",@"网球"],
                                                @[@"足球",@"足球",@"足球",@"足球",@"足球",@"足球",@"足球",@"足球",@"足球"],
                                                @[@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球"],
                                                @[@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球"],
                                                @[@"网球",@"网球",@"网球",@"网球",@"网球",@"网球",@"网球",@"网球",@"网球"],
                                                @[@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球",@"蓝球"],
                                                @[@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球",@"排球"],
                                                ];
        
        
        

        
    }
    
    return self;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 主列表
    if (tableView==self.masterTableView) {
        
        return [self.masterArray  count];
        
    }
    
    // 子列表
    else {
        
        NSArray *detailArray=self.detailArrayArray[self.masterSelectedIndexPath.row];
        
        return [detailArray  count];
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.masterTableView) {
        
        static NSString *masterCellIdentifier=@"MasterCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:masterCellIdentifier];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:masterCellIdentifier];
        }
        
        cell.textLabel.text=self.masterArray[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
    }
    else {
        
        static NSString *detailCellIdentifier=@"DetailCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
        }
        
        cell.textLabel.text=self.detailArrayArray[self.masterTableView.indexPathForSelectedRow.row][indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        cell.backgroundColor=[UIColor clearColor];
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.masterTableView) {
        
        [self.detailTableView reloadData];
        
    }
    else {
        
        //将master和detail的信息传递给detail
        [self.delegate selectRowAtDetailIndexPath:indexPath andMasterIndexPath:self.masterTableView.indexPathForSelectedRow];
        
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ios 不能设置 rowheight
    return 30;
    
}


@end
