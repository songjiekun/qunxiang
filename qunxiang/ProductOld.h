//
//  Product.h
//  qunxiang
//
//  Created by song jiekun on 15/6/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageWithCache.h"


@interface Product : NSObject


//strong or copy???

@property (strong, nonatomic) NSString *productDescription;
@property (strong, nonatomic) NSString *productCategory;
@property (strong, nonatomic) NSNumber *productPice;
@property (strong, nonatomic) ImageWithCache *productImage;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSDate *updatedAt;


+(id)productOfDescription:(NSString*)productDescrption category:(NSString*)productCategory price:(NSNumber*)productPrice url:(NSString*)imageUrl createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt;

-(void)submitProduct:(UIImage*)productImage;

+(void)reloadProducts:(id)target action:(SEL)reload beforeDate:(NSDate*)beforeDate;


@end
