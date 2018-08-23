//
//  JLPhotoBrowser.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/7.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "JLPhotoBrowser.h"
#import "JLPhotoBrowserView.h"
#import "UIImageView+WebCache.h"
#define Itemwidth 20
@interface JLPhotoBrowser()<UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    CGFloat imgitemwidth;//每组图片间距
    CGPoint firstPoint;//第一次触摸点
    CGPoint endPoint;//结束触摸点
    
}
@property (nonatomic, strong) UIScrollView *JLPhotoScrollView;//主滑动视图
@property (nonatomic, strong)   UIPanGestureRecognizer *panges;
@property (nonatomic, strong) UIPageControl *JlPageView;
@property (nonatomic, strong) UIImageView *animatmageView;//全局的显示动画效果的图片,第一次加载，下滑，再次点击出现
@property (nonatomic, copy) void(^DismissVIew)(BOOL issure,NSInteger currentpage);
@end


@implementation JLPhotoBrowser// andCurrent:(NSInteger)Current andImageUrlArr:(NSArray*)ImageUrlArr
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor blackColor];
        [self addSubview:self.JLPhotoScrollView];
        self.JLPhotoScrollView.hidden =YES;
        [self addSubview:self.JlPageView];
        imgitemwidth =Itemwidth;
       
    }
    return  self;
}

-(UIScrollView *)JLPhotoScrollView{
    if (!_JLPhotoScrollView) {
        _JLPhotoScrollView =[[UIScrollView alloc]initWithFrame:self.frame];
        _JLPhotoScrollView.pagingEnabled =YES;
        _JLPhotoScrollView.delegate = self;
        _JLPhotoScrollView.showsHorizontalScrollIndicator = NO;
        _JLPhotoScrollView.showsVerticalScrollIndicator = NO;
                self.panges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(JLPhotoPress:)];
                 self.panges.delegate = self;
                [_JLPhotoScrollView addGestureRecognizer: self.panges ];

    }
    return _JLPhotoScrollView;
}
-(UIPageControl *)JlPageView{
    if (!_JlPageView) {
        _JlPageView =[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.self.frame.size.height-50-30, self.frame.size.width, 30)];
        _JlPageView.currentPageIndicatorTintColor = [UIColor redColor];
    }
    [self addSubview:_JlPageView];
    return _JlPageView;
}

-(void)Setup{
    //根据数据生成UI
    _JlPageView.numberOfPages = _ImageUrlArr.count;
    _JlPageView.currentPage = _Current;
    _JLPhotoScrollView.contentSize =CGSizeMake(self.frame.size.width*_ImageUrlArr.count, self.frame.size.height);
    //itemWidth 设置每一个图片的间距默认是20
    CGFloat itemWidth = _JLPhotoScrollView.bounds.size.width + imgitemwidth * 2.0;
    for (int i=0; i<self.ImageUrlArr.count; i++) {
        JLPhotoBrowserView *view =[[JLPhotoBrowserView alloc]initWithFrame:CGRectMake(self.frame.size.width *i, 0, self.frame.size.width, self.frame.size.height) andplaceholderImage:_placeholderImage];
        //点击手势
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JLPhototagclick:)]];
        view.tag =i+1000;
        //长按手势
        [view addGestureRecognizer:[[UILongPressGestureRecognizer      alloc]initWithTarget:self action:@selector(JLPhotoLongtagclick:)]];
        //有问题
        //设置每个图片间距
        CGRect frame = _JLPhotoScrollView.bounds;
        frame.origin.x = itemWidth * i;
        frame.origin.y = 0;
        frame.size.width = itemWidth;
        view.frame = CGRectInset(frame, imgitemwidth, 0);  //缩小至适应屏幕

        [_JLPhotoScrollView addSubview:view];
    }
    _JLPhotoScrollView.frame = CGRectMake(-imgitemwidth, 0, itemWidth, self.frame.size.height);
    CGSize pageViewSize = _JLPhotoScrollView.bounds.size;
    [_JLPhotoScrollView setContentSize:CGSizeMake(itemWidth * _ImageUrlArr.count, pageViewSize.height)];

  
}

-(void)show:(DismissJLView)black{
    [self Setup];
    [_JLPhotoScrollView setContentOffset:CGPointMake(_JLPhotoScrollView.bounds.size.width*_Current, 0)];
    if (_Current==0) {
        [self showCurretImageViewwithIndex:0];
    }
    self.DismissVIew =black;
    //加载第一张图片
    UIImage *fristimage;
    if ([_fristView isKindOfClass:[UIButton class]]) {
        //判断点击的是butt
        UIButton *butt =(UIButton *)_fristView;
        fristimage =butt.imageView.image;
    }else if ([_fristView isKindOfClass:[UIImageView class]]){
        //点击的图片
        UIImageView *img =(UIImageView *)_fristView;
        fristimage =img.image;
    }
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[_fristView convertRect: _fristView.bounds toView:window];
    _animatmageView=[[UIImageView alloc]initWithFrame:rect];
    _animatmageView.contentMode = UIViewContentModeScaleAspectFit;
    //将第一次进入显示的图片插入到UIPageControl后面
    [self insertSubview:_animatmageView belowSubview:_JlPageView];
    
    _animatmageView.image =fristimage;
    [UIView animateWithDuration:0.3 animations:^{
        //第一张动画
        _animatmageView.frame =self.frame;
    } completion:^(BOOL finished) {
        //
        if (finished) {
            //完成hou
            _animatmageView.hidden =YES;
            _JLPhotoScrollView.hidden =NO;
        }
    }];
}
#pragma mark ---单击返回
-(void)JLPhototagclick:(UITapGestureRecognizer *)tag{
    JLPhotoBrowserView *view =(JLPhotoBrowserView *)tag.view;
     UIImageView *lastimageview =[[UIImageView alloc]initWithFrame:self.frame];
    lastimageview.contentMode = UIViewContentModeScaleAspectFit;
    //将第一次进入显示的图片插入到UIPageControl后面
    [self insertSubview:lastimageview belowSubview:_JlPageView];
  
    _JLPhotoScrollView.hidden =YES;
    _JlPageView.hidden =YES;
    lastimageview.image =view.JLPhotoImageView.image;
    [UIView animateWithDuration:0.3 animations:^{
        //第一张动画
        
        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
        NSArray *subarr =_fristView.superview.subviews;
        //遍历查看数组中是否存在非imageview,或者其他视图
        UIView *aview =subarr[(int)_JLPhotoScrollView.contentOffset.x/(int)self.frame.size.width];
        
        CGRect rect=[aview convertRect: aview.bounds toView:window];
        lastimageview.frame =rect;
        self.backgroundColor =[UIColor clearColor];
      
    } completion:^(BOOL finished) {
        if (finished) {
            //完成hou
            _DismissVIew(YES,view.tag-1000);
            [self removeFromSuperview];
        }
    }];

}
//-(CGRect )viewSubViewIsOne:(UIView *)aview{
//    //判断用户从哪一个VIew点击进来，uiview(uiimageview ,uibutt),uicollectionviewcell,uitableviewcell并返回frame
//    if ([aview.superview isKindOfClass:[UICollectionView class]]) {
//        //为UICollectionView
//        if (_Current ==_JLPhotoScrollView.contentOffset.x/self.frame.size.width) {
//            //从当前页返回
//            UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//            CGRect rect=[aview convertRect: aview.bounds toView:window];
//
//            return rect ;
//        }else{
//           // UICollectionView *collectView =
//        }
//
//    }
//}
#pragma mark--长按
-(void)JLPhotoLongtagclick:(UILongPressGestureRecognizer *)tag{
    
}
#pragma mark--在滑动过程中判断方向，
-(void)JLPhotoPress:(UIPanGestureRecognizer *)tag{

    
    CGPoint movePoint = [tag locationInView:self.window];
    NSArray *viearrr =_JLPhotoScrollView.subviews;
    if (tag.state ==UIGestureRecognizerStateChanged) {
       JLPhotoBrowserView *view1 =viearrr[(int)_JLPhotoScrollView.contentOffset.x/(int)self.frame.size.width];
        UIView *view =view1.JLPhotoImageView;
        //触摸过程 计算当下滑距离超过10，修改偏移量，和透明度
        if ( (movePoint.y -firstPoint.y>10)) {
            //下滑距离超过10 需要比较view与屏幕最下角距离，设置最大偏移量，和最大缩小量0.5
          CGFloat viewalpha=(movePoint.y -firstPoint.y)/150.00>0.9 ?0:1-(movePoint.y -firstPoint.y)/150.00;
          self.backgroundColor=self.JLPhotoScrollView.backgroundColor =view1.backgroundColor= [UIColor colorWithWhite:0.2 alpha:viewalpha];
          CGAffineTransform translation = CGAffineTransformMakeTranslation(movePoint.x-firstPoint.x,(movePoint.y -firstPoint.y)*2);
          CGAffineTransform scaleTranslation;
            if (1-(movePoint.y -firstPoint.y)/150.0>=0.5 ) {
                if ((movePoint.y -firstPoint.y)*2 +view.frame.size.height>=self.frame.size.height) {
                translation = CGAffineTransformMakeTranslation(movePoint.x-firstPoint.x,self.frame.size.height-view.frame.size.height);
                    scaleTranslation = CGAffineTransformScale(translation,0.5,0.5);
                }else{
                scaleTranslation = CGAffineTransformScale(translation, 1-(movePoint.y -firstPoint.y)/150.0,1-(movePoint.y -firstPoint.y)/150.0);
                }

            }else{
                if ((movePoint.y -firstPoint.y)*2 +view.frame.size.height>=self.frame.size.height) {
                    translation = CGAffineTransformMakeTranslation(movePoint.x-firstPoint.x,(movePoint.y -firstPoint.y)*2);
                    scaleTranslation = CGAffineTransformScale(translation,0.5,0.5);
                }else{
                    scaleTranslation = CGAffineTransformScale(translation,0.5,0.5);
                }
             
            }
      
            view.transform = scaleTranslation;
        }
        
    }else if (tag.state==UIGestureRecognizerStateEnded){
        
          JLPhotoBrowserView *view1 =viearrr[(int)_JLPhotoScrollView.contentOffset.x/(int)self.frame.size.width];
        UIView *view =view1.JLPhotoImageView;
        CGFloat viewwidth =view.frame.size.width;
        if (view.frame.origin.x>viewwidth|| view.frame.origin.y>view1.frame.size.height) {
            //移除该试图

            [UIView animateWithDuration:0.3 animations:^{
                //第一张动画
                UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
                NSArray *subarr =_fristView.superview.subviews;
                UIView *aview =subarr[(int)_JLPhotoScrollView.contentOffset.x/(int)self.frame.size.width];
                CGRect rect=[aview convertRect: aview.bounds toView:window];
                view.frame =rect;
                self.backgroundColor =[UIColor clearColor];
                
            } completion:^(BOOL finished) {
                if (finished) {
                    //完成hou
                    _DismissVIew(YES,view.tag-1000);
                    [self removeFromSuperview];
                }
            }];

        }else{
            //结束触摸 记录拖动距离，判断是回到原图片浏览器位置，还是移出屏幕
            
            
            [UIView animateWithDuration:0.3 animations:^{
                self.backgroundColor=self.JLPhotoScrollView.backgroundColor =view1.backgroundColor= [UIColor colorWithWhite:0 alpha:1];
                CGAffineTransform transform1 = CGAffineTransformMakeTranslation(0,0);
                view.transform = CGAffineTransformScale(transform1, 1, 1);
                
                
            } completion:^(BOOL finished) {
                
            }];
        }

        
    }else if (tag.state ==UIGestureRecognizerStateBegan){
        //开始触摸
    
    }
    
}

#pragma mark ---滑动时加载图片
-(void)showCurretImageViewwithIndex:(NSInteger)Index{
    //可以优先判断图片是否加载
    NSArray *imgarr =self.JLPhotoScrollView.subviews;
    JLPhotoBrowserView *JlPhoto =imgarr[Index];
    if (JlPhoto.isdownload) {
        //减少执行步骤
        return ;
    }
    //无缓存或者第一次加载图片走这个方法
    [JlPhoto setPhotoIamgewithimageurl:self.ImageUrlArr[Index]];
 
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //判断是否是上下滑动  滑动区间设置为+-10
    CGPoint touchPoint = [gestureRecognizer locationInView:self.window];
//    CGPoint touchPoint1 =[gestureRecognizer translationInView:self.window];
//    NSLog(@"%lf,%lf",)
    CGFloat dirTop = firstPoint.y - touchPoint.y;
  //  NSLog(@"%lf",dirTop);
    if (dirTop < -10 || dirTop > 10) {
//          self.JLPhotoScrollView.scrollEnabled = NO;
        NSLog(@"1111111111111111111111111111111");
        return YES;
    }
    //判断是否是左右滑动
    CGFloat dirLift = firstPoint.x - touchPoint.x;
   // NSLog(@"%lf",dirLift);
    if (dirLift < -10 || dirLift > 10 ) {
        NSLog(@"222222222222222222222222222222");
        return NO;
    }
//
    NSLog(@"33333333333333333333333333333333333");
    return NO;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.panges ==gestureRecognizer) {
        firstPoint = [touch locationInView:self.window];
    }

    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*) gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer
{
//    if (gestureRecognizer ==self.panges ||otherGestureRecognizer ==self.panges) {
//        return NO;
//    }
    return  NO;
}
#pragma mark ---scrollViewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     int index = (scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5) / scrollView.bounds.size.width;
      CGFloat x = scrollView.contentOffset.x;
    //解决第一次滑动时显示不流畅问题。只要左滑一下，直接加载左边图片，右滑同理
    if(x-scrollView.bounds.size.width*index >0){
        //右滑
        if (index+1<=_ImageUrlArr.count-1) {
               [self showCurretImageViewwithIndex:index+1];
            return ;
        }
        
    }else if(x-scrollView.bounds.size.width*index <0){
        //左滑
        if (index-1>=0) {
            [self showCurretImageViewwithIndex:index-1];
            return ;
        }
    }
    
    [self showCurretImageViewwithIndex:index];
    _JlPageView.currentPage =scrollView.contentOffset.x/self.frame.size.width;
}


@end
