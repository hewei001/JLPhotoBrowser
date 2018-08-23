//
//  JLPhotoBrowserView.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/7.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "JLPhotoBrowserView.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#define HEIGHT 
@interface JLPhotoBrowserView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *JLPhotoScrollView;//放大缩小等手势需要在UIScrollView实现
@property (nonatomic, copy) NSString *placeholderImage;//默认背景图片

//@property (nonatomic, assign) float scale;//缩放比例
//@property (nonatomic, assign) float lastscale;//记录上一次缩放量
@end

@implementation JLPhotoBrowserView

-(instancetype)initWithFrame:(CGRect)frame andplaceholderImage:(NSString *)placeholderImage{
    self =[super initWithFrame:frame];
    if (self) {
        self.placeholderImage = placeholderImage;
        self.backgroundColor = [UIColor blackColor];
        self.userInteractionEnabled =YES;
        [self addSubview:self.JLPhotoScrollView];
        [self.JLPhotoScrollView addSubview:self.JLPhotoImageView];
//        self.scale =1.0;
//        self.lastscale =1.0;
    }
    
    return self;
}
-(UIScrollView *)JLPhotoScrollView{
    if (!_JLPhotoScrollView ) {
        self.JLPhotoScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.JLPhotoScrollView.contentSize = self.bounds.size;
        self.JLPhotoScrollView.minimumZoomScale = 0.5;
        self.JLPhotoScrollView.maximumZoomScale = 10;
        self.JLPhotoScrollView.delegate = self;
//        [self.JLPhotoScrollView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(Pinchclick:)]];
        
    }
    return  _JLPhotoScrollView;
}
-(UIImageView *)JLPhotoImageView{
    if (!_JLPhotoImageView ) {
        self.JLPhotoImageView =[[UIImageView alloc]initWithFrame:_JLPhotoScrollView.frame];
        self.JLPhotoImageView.userInteractionEnabled =YES;
        self.JLPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.JLPhotoImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2959260478,3859257050&fm=27&gp=0.jpg"] placeholderImage:[[SDImageCache sharedImageCache]imageFromDiskCacheForKey:self.placeholderImage]];
    }
    return  _JLPhotoImageView;
}
//允许多点交互
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//
//    return YES;
//
//}
-(void)setPhotoIamgewithimageurl:(NSString *)imgurl{
    //设置加载图片 重启后先从本地拿
    if ([[SDImageCache sharedImageCache]imageFromDiskCacheForKey:imgurl ]) {
        _JLPhotoImageView.image =[[SDImageCache sharedImageCache]imageFromDiskCacheForKey:imgurl ];
        _isdownload = YES;
        return ;
    }
    
    //无缓存，开始请求
    [SVProgressHUD showProgress:0];

    [_JLPhotoImageView sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:[UIImage imageNamed:self.placeholderImage] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //设置进度
        [SVProgressHUD showProgress: (CGFloat)receivedSize / expectedSize];
        if ((CGFloat)receivedSize / expectedSize==1) {
            _isdownload = YES;
            [SVProgressHUD dismiss];
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         [SVProgressHUD dismiss];//已缓存的项目，再次进入
        if (error) {
            //图片加载失败
            [SVProgressHUD showErrorWithStatus:@"图片加载失败"];
            return ;
        }
        _isdownload = YES;
        _JLPhotoImageView.image =image;
    //    [_JLPhotoScrollView setNeedsDisplay];
    }];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _JLPhotoImageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGRect frame = self.JLPhotoImageView.frame;
    
    frame.origin.y = (self.JLPhotoScrollView.frame.size.height - self.JLPhotoImageView.frame.size.height) > 0 ? (self.JLPhotoScrollView.frame.size.height - self.JLPhotoImageView.frame.size.height) * 0.5 : 0;
    
    frame.origin.x = (self.JLPhotoScrollView.frame.size.width - self.JLPhotoImageView.frame.size.width) > 0 ? (self.JLPhotoScrollView.frame.size.width - self.JLPhotoImageView.frame.size.width) * 0.5 : 0;
    NSLog(@"%lf----%lf", frame.origin.x,frame.origin.y );
    self.JLPhotoImageView.frame = frame;
    
    self.JLPhotoScrollView.contentSize = CGSizeMake(self.JLPhotoImageView.frame.size.width + 30, self.JLPhotoImageView.frame.size.height + 30);
}


#pragma mark--刚开始用捏合手势做，发现放大中心点问题和一些效果，设置锚点后还是没有解决
//-(void)Pinchclick:(UIPinchGestureRecognizer *)tag{
//
////    UIView *piece = tag.view;
////    //获得当前手势在view上的位置。
////    CGPoint locationInView = [tag locationInView:piece];
////    piece.layer.anchorPoint =CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
////    //防止设置完锚点过后，view的位置发生变化，相当于把view的位置重新定位到原来的位置上。
////    CGPoint locationInSuperview = [tag locationInView:piece];
////    piece.center = locationInSuperview;
//
//    CGFloat temp =self.scale + (tag.scale-1);
//    [self scaleimgview:temp];
//
//
//}
//
//-(void)scaleimgview:(CGFloat)tepm{
//    //最高放大3.0 最小0.2
//    if (_scale<=3&&tepm<=3&&_scale>=0.2&&tepm>=0.2) {
//
//    _scale =tepm;
//        if (_scale>1) {
//            //方法状态
//              self.JLPhotoImageView.transform =CGAffineTransformMakeScale(tepm, tepm);
//            CGFloat maxw = _JLPhotoImageView.frame.size.width;
//            //？？？？？
//            CGFloat maxh = MAX(_JLPhotoImageView.frame.size.height, self.frame.size.height);
//
//            _JLPhotoImageView.center = CGPointMake(maxw * 0.2, maxh * 0.2);
//            _JLPhotoScrollView.contentSize = CGSizeMake(maxw, maxh);
//            NSLog(@"%lf---%lf",maxw,maxh);
//
//            CGPoint offset = _JLPhotoScrollView.contentOffset;
//            offset.x = (maxw - _JLPhotoScrollView.frame.size.width) * 0.2;
//            _JLPhotoScrollView.contentOffset = offset;
//        }else if (_scale<1){
//            //缩小状态
//
//
//        }
//
//    }
//}
@end
