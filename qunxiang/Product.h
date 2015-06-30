//
//  Product.h
//  qunxiang
//
//  Created by song jiekun on 15/6/25.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

//@class NSManagedObject;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * productCategory;
@property (nonatomic, retain) NSString * productDescription;
@property (nonatomic, retain) NSNumber * productPrice;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSOrderedSet *images;

@end

@interface Product (CoreDataGeneratedAccessors)

- (void)insertObject:(NSManagedObject *)value inImagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromImagesAtIndex:(NSUInteger)idx;
- (void)insertImages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeImagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInImagesAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceImagesAtIndexes:(NSIndexSet *)indexes withImages:(NSArray *)values;
- (void)addImagesObject:(NSManagedObject *)value;
- (void)removeImagesObject:(NSManagedObject *)value;
- (void)addImages:(NSOrderedSet *)values;
- (void)removeImages:(NSOrderedSet *)values;
@end
