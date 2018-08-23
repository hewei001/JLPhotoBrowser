//
//  JLPhotoBrowserView.h
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/7.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import <UIKit/UIKit.h>
//单个显示图片VIew
@interface JLPhotoBrowserView : UIView
@property (nonatomic, strong) UIImageView *JLPhotoImageView;//展示图片
@property (nonatomic, assign) bool isdownload;//是否缓存成功
-(instancetype)initWithFrame:(CGRect)frame andplaceholderImage:(NSString *)placeholderImage;
-(void)setPhotoIamgewithimageurl:(NSString *)imgurl;
@end
