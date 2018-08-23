//
//  TestTableViewCell.h
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/11.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (nonatomic, copy) void (^seeimg)(UIView *view);
-(void)makedata;
@end
