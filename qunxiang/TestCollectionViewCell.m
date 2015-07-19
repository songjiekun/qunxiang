//
//  TestCollectionViewCell.m
//  qunxiang
//
//  Created by song jiekun on 15/7/19.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //self.contentView.frame=self.bounds;
    //self.contentView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
}

-(void)setBounds:(CGRect)bounds{
    
    [super setBounds:bounds];
    self.contentView.frame=bounds;
    
}

@end
