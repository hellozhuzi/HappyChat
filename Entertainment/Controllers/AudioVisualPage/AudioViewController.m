//
//  AudioViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "AudioViewController.h"
#import "AudioTopCell.h"
#import "AudioBigModel.h"
#import "AudioBigCell.h"
#import "MusicViewController.h"
@interface AudioViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation AudioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
     _dataArray = [NSMutableArray array];
    //注册观察着
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(gotoNewpage:) name:@"mp3" object:nil];
    
}
- (void)loadData
{
    NSString *str = API_AUDIO;
    [DownloadManager GET:str success:^(NSData *data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _dataArray = [AudioBigModel arrayOfModelsFromDictionaries:dict[@"cList"]];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
        
    }];
}

- (void)creatUI
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    //要加normal
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
        [self loadData];
    }];
    [_tableView.header beginRefreshing];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 45;
    }
    else{
        return 250.5;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        static NSString *cellId = @"top";
        AudioTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell == nil){
            cell = [[AudioTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    
    }
    else{
        static NSString *cellId = @"audio";
        AudioBigCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(cell==nil){
            cell = [[AudioBigCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = _dataArray[indexPath.row-1];
        return cell;
    }

    
}
- (void)gotoNewpage:(NSNotification *)notification
{
    MusicViewController *mvc = [[MusicViewController alloc]init];
    mvc.model = notification.object;
    [self.navDelegate pushViewController:mvc animated:YES];
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
