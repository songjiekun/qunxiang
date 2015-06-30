//
//  ImageWithCache.h
//  qunxiang
//
//  Created by song jiekun on 15/6/20.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

//图片的状态
typedef NS_ENUM(NSInteger, ImageState){
    
    ImageStateNew,
    ImageStateCached,
    ImageStateDisked,
    ImageStateDownloaded,
    ImageStateFailed
    
};


@class ImageWithCache;

@protocol ImageWithCacheDelegate <NSObject>

//代理将更新UI
-(void)refreshImage:(ImageWithCache *)sender withImage:(UIImage *)newImage;

@end


/**
 ImageWithCache是一个图片载入的类
 分三步来载入图片
 1.检查nscache中是否有内存缓存
 2.检查磁盘中是否有文件已经存在
 3.从互联网下载图片
 **/
@interface ImageWithCache : NSObject

//imageID对于同一个图片必须是独一无二的
@property (strong, nonatomic) NSString *imageUrl;
@property (nonatomic,readonly) ImageState theState;

@property (nonatomic,weak) id <ImageWithCacheDelegate> delegate;


//通过url来初始化
-(id)initWithImageUrl:(NSString *)imageUrl;

/**
 获取图片 在方法中调用代理对ui进行更新
 返回一张placeholder图片
 sender用来获取是哪个view调用了这个方法，以便在ui更新时能找到这个view
 cache是整个程序的memory NSCache
 **/
-(UIImage *)retrieveImage:(id)sender fromCache:(NSCache *)cache atIOQueue:(NSOperationQueue *)ioQueue atInternetQueue:(NSOperationQueue *)internetQueue;

//取消图片的下载等操作
-(void)cancel;

@end
