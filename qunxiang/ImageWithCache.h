//
//  ImageWithCache.h
//  qunxiang
//
//  Created by song jiekun on 15/6/25.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@class Product;

@interface ImageWithCache : NSManagedObject

@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) Product *product;

@end
