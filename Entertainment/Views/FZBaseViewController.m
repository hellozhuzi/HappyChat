//
//  BaseViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/22.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "FZBaseViewController.h"
#import "NYSegmentedControl.h"
#import "SegmentModel.h"
#import "RecommendReadViewController.h"
#import "MyReadViewController.h"
@interface FZBaseViewController ()<UIScrollViewDelegate>
{
    NYSegmentedControl *_segment;
    UIScrollView *_mainScrollView;
}
@end

@implementation FZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
}
- (void)setupUI
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_background@2x.png"] forBarMetrics:UIBarMetricsDefault];
}

/*
 */
-(void)creatMuduleSegmentWithArray:(NSArray *)modelsArray
{
    
    _vcArray = [NSMutableArray array];
    //控件
    [self creatSegmentWithArray:modelsArray];
    //页面
    [self creatScrollView];
    [self creatSubPageWithArray:modelsArray];
}
-(void)creatSegmentWithArray:(NSArray *)modelsArray
{

    NSMutableArray *btnNameArray = [NSMutableArray array];
    for (SegmentModel *model in modelsArray) {
        [btnNameArray addObject:model.btnName];
    }
    _segment = [[NYSegmentedControl alloc]initWithItems:btnNameArray];
    [_segment setBorderColor:[UIColor colorWithWhite:1.0f alpha:1]];
    [_segment setBorderWidth:2.f*0.618];
    
    [_segment setSegmentIndicatorInset:0.618];
    [_segment setDrawsSegmentIndicatorGradientBackground:YES];
    [_segment setSegmentIndicatorGradientBottomColor:[UIColor redColor]];
    [_segment setSegmentIndicatorGradientTopColor:[UIColor redColor]];
    [_segment setSegmentIndicatorAnimationDuration:0.3f];
    
    [_segment.layer setCornerRadius:15.f];
    [_segment setTitleTextColor:[UIColor blackColor]];
    [_segment setSelectedTitleTextColor:[UIColor whiteColor]];
    [_segment setFrame:CGRectMake(0, 0, 200, 30)];
    [_segment setSelectedSegmentIndex:0];
    [_segment addTarget:self action:@selector(segmentPressed:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:_segment];
}
-(void)creatScrollView
{
    CGRect rect = self.view.bounds;
    rect.origin.y = 0;
    rect.size.height -= 49;
    _mainScrollView = [[UIScrollView alloc]initWithFrame:rect];
    [_mainScrollView setPagingEnabled:YES];
    [_mainScrollView setDelegate:self];
    _mainScrollView.userInteractionEnabled = YES;
    [self.view addSubview:_mainScrollView];
}

-(void)creatSubPageWithArray:(NSArray *)array
{
    int i = 0;
    for (SegmentModel *model in array) {
        NSString *vcName = model.vcName;
        Class cls = NSClassFromString(vcName);
        UIViewController *vc =[[cls alloc]init];
        vc.view.frame = CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT);
        [_mainScrollView addSubview:vc.view];
        [_vcArray addObject:vc];
        i++;
    }
    
    [_mainScrollView setContentSize:CGSizeMake(WIDTH * 2, 0)];
}
-(void)segmentPressed:(NYSegmentedControl *)sender
{

    [UIView animateWithDuration:0.3 animations:^{
        
        [_mainScrollView setContentOffset:CGPointMake( WIDTH*sender.selectedSegmentIndex,0) animated:YES];
    }];
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
