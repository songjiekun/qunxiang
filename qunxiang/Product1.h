//
//  Product.h
//  qunxiang
//
//  Created by song jiekun on 15/6/25.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ImageWithCache.h"

@class NSManagedObject;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSNumber * productPrice;
@property (nonatomic, retain) NSString * productCategory;
@property (nonatomic, retain) NSString * productDescription;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *images;

@property (strong, nonatomic) ImageWithCache *productImage;

+(id)productOfDescription:(NSString*)productDescrption category:(NSString*)productCategory price:(NSNumber*)productPrice url:(NSString*)imageUrl createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt context:(NSManagedObjectContext *)managedObjectContext;
-(void)submitProduct:(UIImage*)productImage;
+(void)reloadProducts:(id)target action:(SEL)reload beforeDate:(NSDate*)beforeDate context:(NSManagedObjectContext *)managedObjectContext;

@end
