//
//  JLPhotoBrowser.h
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/7.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DismissJLView)(BOOL issure,NSInteger currentpage);

@interface JLPhotoBrowser : UIView
//图片浏览器
@property (nonatomic, strong) NSArray *ImageUrlArr;//总的图片地址数组
@property (nonatomic, assign) int ChooseIndex;//选择图片下标
@property (nonatomic, assign) NSInteger Current;//进入图片浏览器默认选中页，默认第0页
@property (nonatomic, copy) NSString *placeholderImage;//默认背景图片
@property (nonatomic,strong)UIView *fristView;//第一张图片

-(void)show:(DismissJLView)black;

@end
