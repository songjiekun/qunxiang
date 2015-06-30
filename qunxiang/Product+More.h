//
//  Product+More.h
//  qunxiang
//
//  Created by song jiekun on 15/6/26.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "Product.h"

@interface Product (More)

+(id)productOfDescription:(NSString*)productDescrption category:(NSString*)productCategory price:(NSNumber*)productPrice url:(NSString*)imageUrl createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt context:(NSManagedObjectContext *)managedObjectContext;
-(void)submitProduct:(UIImage *)productImage;
+(void)reloadProducts:(id)target action:(SEL)reload beforeDate:(NSDate*)beforeDate context:(NSManagedObjectContext *)managedObjectContext;

@end
