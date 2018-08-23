//
//  TestTableViewCell.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/11.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "TestTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "JLPhotoBrowser.h"
@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)makedata{
    [_img1 sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1972873509,2904368741&fm=27&gp=0.jpg"]];
    _img1.userInteractionEnabled =YES;
    _img1.contentMode = UIViewContentModeScaleAspectFit;
    [_img1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
    
    [_img2 sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=60332803,1042811346&fm=202&mola=new&crop=v1"]];
    _img2.userInteractionEnabled =YES;
    _img2.contentMode = UIViewContentModeScaleAspectFit;
    [_img2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
    
    [_img3 sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=880709080,1721359692&fm=202&mola=new&crop=v1"]];
    _img3.userInteractionEnabled =YES;
    _img3.contentMode = UIViewContentModeScaleAspectFit;
    [_img3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
    
    [_img4 sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=474291294,2674600622&fm=202&mola=new&crop=v1"]];
    _img4.userInteractionEnabled =YES;
    _img4.contentMode = UIViewContentModeScaleAspectFit;
    [_img4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagclick:)]];
}
-(void)tagclick:(UITapGestureRecognizer *)tag{
    //
    _seeimg(tag.view);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
