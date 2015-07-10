//
//  ProductSectionHeader.m
//  qunxiang
//
//  Created by song jiekun on 15/7/7.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductSectionHeader.h"

@implementation ProductSectionHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ProductSectionHeader" owner:self options:nil];
        UIView *nibView = views[0];
        
        UIView *contentView = self.contentView;
        [contentView addSubview:nibView];
        
        //设置autolayout
        nibView.translatesAutoresizingMaskIntoConstraints=NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nibView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(nibView)]];
        
        
    }
    return self;
}

@end
