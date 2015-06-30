//
//  ProductMore.m
//  qunxiang
//
//  Created by song jiekun on 15/6/26.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "ProductMore.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ImageWithCacheMore.h"

@implementation ProductMore

//初始化product对象
+(id)productOfDescription:(NSString*)productDescrption category:(NSString*)productCategory price:(NSNumber*)productPrice url:(NSString*)imageUrl  createdDate:(NSDate*)createdAt updatedDate:(NSDate*)updatedAt context:(NSManagedObjectContext *)managedObjectContext{
    
    // Create Entity
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:managedObjectContext];
    
    // Initialize Record
    ProductMore *newProduct = (ProductMore *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:managedObjectContext];
    
    newProduct.productDescription=productDescrption;
    newProduct.productPrice=productPrice;
    
    if (imageUrl) {
        
        ImageWithCacheMore *newImage=[ImageWithCacheMore imageWithUrl:imageUrl andProduct:newProduct context:managedObjectContext];
        
        [newProduct addImagesObject:newImage];
        
    }
    
    newProduct.productCategory=productCategory;
    newProduct.createdAt=createdAt;
    newProduct.updatedAt=updatedAt;
    
    return newProduct;
    
}

-(void)submitProduct:(UIImage*)productImage{
    
    //NSString *description=[product objectForKey:@"productDescription"];
    //NSNumber *price=[product objectForKey:@"productPrice"];
    //NSString *category=[product objectForKey:@"productCategory"];
    //UIImage *image=[UIImage imageNamed:[product objectForKey:@"imageName"]];
    
    
    NSString *description=self.productDescription;
    NSNumber *price=self.productPrice;
    NSString *category=self.productCategory;
    UIImage *image=productImage;
    
    //存储图片文件
    NSData *data=UIImageJPEGRepresentation(image, 0.2);
    AVFile *file=[AVFile fileWithName:@"test.jpg" data:data];
    
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        //存储product对象
        AVObject *productObject = [AVObject objectWithClassName:@"Product"];
        [productObject setObject:description forKey:@"productDescription"];
        [productObject setObject:price forKey:@"productPrice"];
        [productObject setObject:category forKey:@"productCategory"];
        [productObject setObject:file forKey:@"productImage1"];
        
        [productObject saveInBackground];
        
    }];
    
}

+(void)reloadProducts:(id)target action:(SEL)reload beforeDate:(NSDate*)beforeDate context:(NSManagedObjectContext *)managedObjectContext{
    
    AVQuery *query = [AVQuery queryWithClassName:@"Product"];
    
    //查询products的条件
    [query whereKey:@"productPrice" greaterThan:[NSNumber numberWithInt:0]];
    
    if (beforeDate!=nil) {
        [query whereKey:@"createdAt" lessThan:beforeDate];
    }
    
    [query orderByDescending:@"createdAt"];
    query.limit=2;
    query.skip=0;
    
    //查询products
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (error) {
            
            
            
        }
        else{
            
            //NSMutableArray *reloadedProducts=[[NSMutableArray alloc] initWithCapacity:objects.count];
            
            //将获取的数据填充入product数组中
            for(AVObject *object in objects) {
                NSNumber *productPrice = [object objectForKey:@"productPrice"];
                NSString *productDescription= [object objectForKey:@"productDescription"];
                NSString *productCategory= [object objectForKey:@"productCategory"];
                NSDate *createdAt=[object objectForKey:@"createdAt"];
                NSDate *updatedAt=[object objectForKey:@"updatedAt"];
                AVFile *productImage1File=[object objectForKey:@"productImage1"];
                NSString *imageUrl = productImage1File.url;
                
                //此时refetchedResultsController并没有发生变化 因为还没有调用delegate.
                ProductMore *newProduct = [ProductMore productOfDescription:productDescription category:productCategory price:productPrice url:imageUrl createdDate:createdAt updatedDate:updatedAt context:managedObjectContext];
                //[reloadedProducts addObject:newProduct];
                
            }
            
            //这里使用target action 可以保证所有的AVObject的调用都在product里面完成
            
            if ([target respondsToSelector:reload]) {
                
                [target performSelector:reload];
                
            }
            
        }
        
    }];
    
}


@end
