//
//  Product.m
//  qunxiang
//
//  Created by song jiekun on 15/6/25.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "Product.h"
//#import "NSManagedObject.h"


@implementation Product

@dynamic createdAt;
@dynamic productCategory;
@dynamic productDescription;
@dynamic productPrice;
@dynamic updatedAt;
@dynamic images;


//由于原始的addImagesObject 有bug，所以需要重写
- (void)addImagesObject:(NSManagedObject *)value{
    
    NSMutableOrderedSet* tempSet =[NSMutableOrderedSet orderedSetWithOrderedSet:self.images];
    [tempSet addObject:value];
    self.images=tempSet;
    
}



@end
