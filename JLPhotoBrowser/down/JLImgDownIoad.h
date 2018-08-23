//
//  JLImgDownIoad.h
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/25.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JLImgDownIoad : NSObject
@property (nonatomic, copy) void(^JLWebImageDownloaderProgressBlock)(NSInteger prosize,NSInteger competesize) ;
@property (nonatomic, copy) void(^JLWebImageDownCompleteBlock)( UIImage *image, NSError *error) ;
-(void)downIoadImageForUrl:(NSString *)url;
+(nonnull instancetype)sharedImageCache;
@end
