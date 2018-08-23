//
//  testtableViewController.m
//  JLPhotoBrowser
//
//  Created by wzc on 2018/6/11.
//  Copyright © 2018年 WZC. All rights reserved.
//

#import "testtableViewController.h"
#import "TestTableViewCell.h"
#import "JLPhotoBrowser.h"
@interface testtableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mytable;
@end

@implementation testtableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mytable =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _mytable.dataSource =self;
    _mytable.delegate =self;
    _mytable.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:_mytable];
   // [_mytable registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:@"TestTableViewCell"];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:nil options:nil] firstObject];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
            [cell makedata];
    cell.seeimg = ^(UIView *view) {
      //图片放大
        JLPhotoBrowser *view1 =[[JLPhotoBrowser alloc] initWithFrame:self.view.window.frame];
        view1.fristView =view;
        view1.placeholderImage =@"placeholder";
        view1.ImageUrlArr =@[@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1972873509,2904368741&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=3545401083,2251952841&fm=77&w_h=121_75&cs=2008984878,1171842780",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=3618554304,2887917621&fm=77&w_h=121_75&cs=2820658166,1330608299",@"https://ss0.bdstatic.com/6ONWsjip0QIZ8tyhnq/it/u=1618097094,4154452434&fm=77&w_h=121_75&cs=423647557,799948659"];
        view1.Current =view.tag-100;
        [view1 show:^(BOOL issure, NSInteger currentpage) {
            //是否返回，从第几页返回
        }];

        [self.view.window addSubview:view1];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  250;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
