//
//  UIImageView+JLloadimg.h
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/22.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
typedef void(^JLWebImageDownloaderProgressBlock)(NSInteger prosize,NSInteger competesize);
typedef void(^JLWebImageDownCompleteBlock)( UIImage *image, NSError *error);


@interface UIImageView (JLloadimg)


/**
 *  存放所有下载操作的队列
 */
@property (nonatomic,strong) NSOperationQueue* queue;

/**
 *  存放所有的下载操作（url是key，operation对象是value）
 */
@property (nonatomic,strong) NSMutableDictionary* operations;

-(void)JLloadimgwith:(NSString *)imgurl andplaceholderImage:(NSString *)placeholderImage;
- (void)JLloadimgwith:( NSString *)url andplaceholderImage:(NSString *)placeholderImage
                                             progress:( JLWebImageDownloaderProgressBlock)progressBlock
                                            completed:( JLWebImageDownCompleteBlock)completedBlock;
@end
