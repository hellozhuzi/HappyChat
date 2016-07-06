//
//  AudioVisualViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/19.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "AudioVisualViewController.h"
#import "SegmentModel.h"
#import "VisualViewController.h"
#import "AudioViewController.h"
@interface AudioVisualViewController ()
{
    VisualViewController *_visualVC;
    AudioViewController *_audioVC;
}
@end

@implementation AudioVisualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSegs];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}
-(void)creatSegs
{
    NSMutableArray *segModels = [NSMutableArray array];
    SegmentModel *model1 = [[SegmentModel alloc]init];
    model1.btnName = @"视频";
    model1.vcName = @"VisualViewController";
    [segModels addObject:model1];
    
    SegmentModel *model2 = [[SegmentModel alloc]init];
    model2.btnName = @"电台";
    model2.vcName = @"AudioViewController";
    [segModels addObject:model2];
    
    [self creatMuduleSegmentWithArray:segModels];
    [self configPage];
  
}
- (void)configPage
{
    _visualVC = self.vcArray[0];
    _audioVC = self.vcArray[1];
    _audioVC.navDelegate = self.navigationController;
    
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
