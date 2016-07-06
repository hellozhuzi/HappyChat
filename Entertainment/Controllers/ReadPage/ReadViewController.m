//
//  ReadViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/19.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "ReadViewController.h"
#import "NYSegmentedControl.h"
#import "RecommendReadViewController.h"
#import "MyReadViewController.h"
#import "SegmentModel.h"
@interface ReadViewController ()<UIScrollViewDelegate>
{
    NYSegmentedControl *_segment;
    UIScrollView *_mainScrollView;
    RecommendReadViewController *_recommendVC;
    MyReadViewController *_myReadVC;
}
@property (nonatomic,strong)NSMutableArray *vcArray;
@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
}
-(void)creatUI
{
    [self creatRightBtn];
 
    [self creatSegs];

}
-(void)creatSegs
{
    NSMutableArray *segModels = [NSMutableArray array];
    SegmentModel *model1 = [[SegmentModel alloc]init];
    model1.btnName = @"推荐阅读";
    model1.vcName = @"RecommendReadViewController";
    [segModels addObject:model1];
    
    SegmentModel *model2 = [[SegmentModel alloc]init];
    model2.btnName = @"我的订阅";
    model2.vcName = @"MyReadViewController";
    [segModels addObject:model2];
    
    [self creatMuduleSegmentWithArray:segModels];
    [self configSubPage];
}
-(void)configSubPage
{
    _recommendVC = self.vcArray[0];
    _myReadVC = self.vcArray[1];
    
    _recommendVC.navDelegate = self.navigationController;
    _recommendVC.vcDelegate = self;
    _recommendVC.url = API_READ;
}
-(void)creatRightBtn
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setBackgroundImage:[UIImage imageNamed:@"top_navigation_readerplus_highlighted@2x.png"]forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    [self.navigationItem setRightBarButtonItem:item];
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
