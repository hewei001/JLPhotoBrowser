//
//  UIImageView+JLloadimg.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/22.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "UIImageView+JLloadimg.h"
#import "JLImgCache.h"
#import "JLImgDownIoad.h"

@implementation UIImageView (JLloadimg)

-(void)JLloadimgwith:(NSString *)imgurl andplaceholderImage:(NSString *)placeholderImage{
    self.image =[UIImage imageNamed:placeholderImage];
    //下载图片
    //下载之前先判断本地有无缓存有从缓存中取

  BOOL fileis =  [[JLImgCache sharedImageCache] lookForImageWithUrl:imgurl];
    if (fileis) {
        //存在直接赋值
        self.image = [[JLImgCache sharedImageCache] imageFromCacheForKey:imgurl];
        return ;
    }
    //开始下载图片
    self.operations=[[NSMutableDictionary alloc]init];
    //取出当前URL对应的下载下载操作

//    [JLImgDownIoad sharedImageCache].JLWebImageDownloaderProgressBlock = ^(NSInteger prosize, NSInteger competesize) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//        });
//    };
//    [JLImgDownIoad sharedImageCache].JLWebImageDownCompleteBlock = ^(UIImage *image, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [[JLImgCache sharedImageCache]saveImageWithUrl:imgurl anddata:UIImagePNGRepresentation(image)];
//            self.image =image;
//        });
//    };
//
//
//    dispatch_queue_t queue =dispatch_get_global_queue(0, 0);
//        [[JLImgDownIoad sharedImageCache] downIoadImageForUrl:imgurl];
//    dispatch_async(queue, ^{
////        NSData *imagedata =[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]];
////        UIImage *imgage =[UIImage imageWithData:imagedata];
//
//
//    });
}
- (void)JLloadimgwith:( NSString *)url andplaceholderImage:(NSString *)placeholderImage
             progress:( JLWebImageDownloaderProgressBlock)progressBlock
            completed:( JLWebImageDownCompleteBlock)completedBlock{
    
}
@end
