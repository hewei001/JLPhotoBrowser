//
//  JLImgCache.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/22.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "JLImgCache.h"

#define ImageviewPAth @"imageViews"
@interface JLImgCache()
@property (strong, nonatomic, nonnull) NSFileManager *fileManager;
@end





static JLImgCache *instance;
@implementation JLImgCache
+(nonnull instancetype)sharedImageCache{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[self alloc]init];
    });
    return instance;
}
-(BOOL)saveImageWithUrl:(nullable NSString *)Key anddata:(nullable NSData *)imagedata{
    //获取沙盒路径，
    
    
    
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *directryPath = [path stringByAppendingPathComponent:ImageviewPAth];
    if (![self.fileManager isExecutableFileAtPath:directryPath]) {
        //判断是否存在此目录，无则创建
        [self.fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    //有些图片URL长度等问题。统一转md5
    NSString *filepath =[NSString stringWithFormat:@"%@/%@",directryPath,[self md5:Key]];
    if (![self.fileManager fileExistsAtPath:filepath]) {
        BOOL isSuccess =[self.fileManager createFileAtPath:filepath contents:nil attributes:nil];
        if (isSuccess) {
            NSLog(@"新建目录成功");
        }
    }
    BOOL isSuccess =[imagedata writeToFile:filepath atomically:YES];
    if (isSuccess) {
        NSLog(@"写入成功");
    }
    return isSuccess;
}
-(NSFileManager *)fileManager{
    if (!_fileManager) {
        _fileManager =[NSFileManager defaultManager];
    }
    return _fileManager;
}
-(BOOL)lookForImageWithUrl:(nullable NSString*)Key{
    NSString *filepath =[self getPathForKey:Key];
    if ([self.fileManager fileExistsAtPath:filepath]) {
        return  YES ;
    }else{
       //本地存在此文件
        return NO;
    }

    //self.fileManager =[NSFileManager defaultManager];
}
- (NSString *) md5:(NSString *) input {
//    const char *cStr = [input UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
//
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
    
    return  input;
}

-(NSString *)getPathForKey:(NSString *)key{
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *directryPath = [path stringByAppendingPathComponent:ImageviewPAth];
    return [NSString stringWithFormat:@"%@/%@",directryPath,[self md5:key]];
}
- ( nullable UIImage *)imageFromCacheForKey:(nonnull NSString *)key{
    //
    NSString *filepath =[self getPathForKey:key];
    NSData *data =[NSData dataWithContentsOfFile:filepath];
    return [[UIImage alloc] initWithData:data] ;
    
}
#pragma mark==清理缓存
-(BOOL)clearMemory{
    BOOL flag = YES;
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *directryPath = [path stringByAppendingPathComponent:ImageviewPAth];
    if ([self.fileManager fileExistsAtPath:directryPath]) {
        //存在此文件
        flag =[self.fileManager removeItemAtPath:directryPath error:nil];
    }else{
        return NO;
    }
    return  flag ;
}
-(BOOL)clearMemoryForKey:(nonnull NSString *)key{
    BOOL flag = YES;
    NSString *filepath =[self getPathForKey:key];
    if ([self.fileManager fileExistsAtPath:filepath]) {
        //存在此文件
        flag =[self.fileManager removeItemAtPath:filepath error:nil];
    }else{
        return NO;
    }
    return  flag ;
}
@end
