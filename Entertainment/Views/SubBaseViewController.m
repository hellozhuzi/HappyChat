//
//  SubBaseViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/10.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "SubBaseViewController.h"

@interface SubBaseViewController ()
{
    UIView *_navView;
}
@end

@implementation SubBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self creatUI];
    // Do any additional setup after loading the view.
}

- (void)creatUI
{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,NAVHEIGHT)];
    _navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navView];
    
}
- (void)setLeftBtnWithImage:(NSString *)imgName
{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(6, 20, 40, 35)];
    [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView addSubview:btn];
}
- (void)setMiddleTitle:(NSString *)str
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(45, 20, WIDTH-90, 30)];
    lable.text = str;
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:20];
    lable.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:lable];
    
}
-(void)back
{
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
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
