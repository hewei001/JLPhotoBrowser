//
//  JLImgCache.h
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/22.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JLImgCache : NSObject
+(nonnull instancetype)sharedImageCache;
//根据图片的url存放图片
-(BOOL)saveImageWithUrl:(nullable NSString *)Key anddata:(nullable NSData *)imagedata;
//判断图片url读图片
-(BOOL)lookForImageWithUrl:(nullable NSString*)Key;
//根据KEY拿到对应的image
- ( nullable UIImage *)imageFromCacheForKey:(nonnull NSString *)key;
-(BOOL)clearMemory;
-(BOOL)clearMemoryForKey:(nonnull NSString *)key;
@end
