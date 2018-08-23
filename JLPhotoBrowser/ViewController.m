//
//  ViewController.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/7.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "ViewController.h"
#import "JLPhotoBrowserView.h"
#import "UIImageView+WebCache.h"
#import "JLPhotoBrowser.h"
#import "UIImageView+JLloadimg.h"
#import "testtableViewController.h"
#import "JLImgCache.h"
@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_img1 JLloadimgwith:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1972873509,2904368741&fm=27&gp=0.jpg" andplaceholderImage:@"12345"];
 //   [_img1 sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1972873509,2904368741&fm=27&gp=0.jpg"]];
    _img1.userInteractionEnabled =YES;
    _img1.contentMode = UIViewContentModeScaleAspectFit;
   [_img1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
   
    [_img2 JLloadimgwith:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=60332803,1042811346&fm=202&mola=new&crop=v1" andplaceholderImage:@"12345"];
  //  [_img2 sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=60332803,1042811346&fm=202&mola=new&crop=v1"]];
    _img2.userInteractionEnabled =YES;
    _img2.contentMode = UIViewContentModeScaleAspectFit;
    [_img2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
    
    
    [_img3 JLloadimgwith:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=880709080,1721359692&fm=202&mola=new&crop=v1" andplaceholderImage:@"12345"];
    //[_img3 sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=880709080,1721359692&fm=202&mola=new&crop=v1"]];
    _img3.userInteractionEnabled =YES;
    _img3.contentMode = UIViewContentModeScaleAspectFit;
    [_img3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
    
    [_img4 JLloadimgwith:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=474291294,2674600622&fm=202&mola=new&crop=v1" andplaceholderImage:@"12345"];
    //[_img4 sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=474291294,2674600622&fm=202&mola=new&crop=v1"]];
    _img4.userInteractionEnabled =YES;
    _img4.contentMode = UIViewContentModeScaleAspectFit;
    [_img4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
    
    UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(JLPhotoPress:)];
    panges.delegate = self;
    [self.view addGestureRecognizer: panges ];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)tagclick:(UITapGestureRecognizer *)tag{
//    testtableViewController *vc =[[testtableViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];
    
   BOOL flag = [[JLImgCache sharedImageCache] clearMemory];
    if (flag) {
        NSLog(@"yes");
    }else{
        NSLog(@"no");
    }
//    UIView *view =tag.view;
//    JLPhotoBrowser *view1 =[[JLPhotoBrowser alloc] initWithFrame:self.view.window.frame];
//    view1.fristView =view;
//    view1.placeholderImage =@"placeholder";
//    view1.ImageUrlArr =@[@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1972873509,2904368741&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=3545401083,2251952841&fm=77&w_h=121_75&cs=2008984878,1171842780",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=3618554304,2887917621&fm=77&w_h=121_75&cs=2820658166,1330608299",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=1618097094,4154452434&fm=77&w_h=121_75&cs=423647557,799948659"];
//    view1.Current =view.tag-100;
//    [view1 show:^(BOOL issure, NSInteger currentpage) {
//        //是否返回，从第几页返回
//    }];
//
//    [self.view.window addSubview:view1];

    
    
    
//    JLPhotoBrowser *view =[[JLPhotoBrowser alloc] initWithFrame:self.view.window.frame];
//    view.fristView =tag.view;
//    view.placeholderImage =@"placeholder";
//    view.ImageUrlArr =@[@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1972873509,2904368741&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=3545401083,2251952841&fm=77&w_h=121_75&cs=2008984878,1171842780",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=3618554304,2887917621&fm=77&w_h=121_75&cs=2820658166,1330608299",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=1618097094,4154452434&fm=77&w_h=121_75&cs=423647557,799948659"];
//    view.Current =tag.view.tag-100;
//    [view show:^(BOOL issure, NSInteger currentpage) {
//        //是否返回，从第几页返回
//    }];
//    [self.view.window addSubview:view];
}

-(void)JLPhotoPress:(UIGestureRecognizer *)tag{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
