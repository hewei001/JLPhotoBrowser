//
//  JLImgDownIoad.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/25.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "JLImgDownIoad.h"

@interface JLImgDownIoad()<NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>
//下载任务
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSMutableData *mData;
@property (nonatomic, assign)float expectLength;
//session会话
@property (nonatomic, strong) NSURLSession *session;
@end
static JLImgDownIoad *instance;
@implementation JLImgDownIoad


+(nonnull instancetype)sharedImageCache{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[self alloc]init];
    });
    return instance;
}
-(void)downIoadImageForUrl:(NSString *)url{
    NSURL *downurl =[[NSURL alloc]initWithString:url];
    self.session =[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    self.downloadTask = [self.session downloadTaskWithURL:downurl];
    
    [self.downloadTask resume];
    
}
-(NSMutableData *)mData{
    if (!_mData) {
        _mData =[[NSMutableData alloc]init];
    }
    return  _mData;
}


#pragma mark--NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    _mData = [NSMutableData data]; //初始化mData
    _expectLength = response.expectedContentLength;//存储一共要共享的数据长度
    if (_expectLength != -1)
    {
        completionHandler(NSURLSessionResponseAllow);//继续传输数据
    }
    else
    {
        completionHandler(NSURLSessionResponseCancel);//如果response里面不包括数据长度信息,就取消数据传输
        NSLog(@"//如果response里面不包括数据长度信息,就取消数据传输");
    }
}
//收到数据时回调方法,会执行多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [self.mData appendData:data];
    
    _JLWebImageDownloaderProgressBlock(_mData.length,_expectLength);
    NSLog(@"%f",_mData.length/_expectLength);
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    [_session finishTasksAndInvalidate];//完成task就invalidata
    if (!error)
    {  
        dispatch_async(dispatch_get_main_queue(), ^{
            _JLWebImageDownCompleteBlock([[UIImage alloc]initWithData:_mData],nil);
            //下载完毕,清空
            _session = nil;
            _downloadTask = nil;
            _mData = nil;
        });
    }
    else
    {
        _JLWebImageDownCompleteBlock(nil,error);
        NSLog(@"error = %@",error.debugDescription);
    }
}

@end
