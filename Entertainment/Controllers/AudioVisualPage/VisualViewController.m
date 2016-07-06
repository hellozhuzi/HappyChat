//
//  VisualViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "VisualViewController.h"
#import "VideoModel.h"
#import "VisualSidModel.h"
#import "VisualSidCell.h"
#import "VisualVideoCell.h"
@interface VisualViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    int _count;
    NSMutableArray *_btnModelsArray;//按钮
    NSMutableArray *_dataArray;//列表数据
}
@end

@implementation VisualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self creatTableView];
    // Do any additional setup after loading the view.
}

-(void)creatTableView
{
    CGRect rect = self.view.bounds;
    rect.size.height -= 64+49;
    
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.separatorStyle = NO;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view  addSubview:_tableView];
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _count = 0;
        [self loadData];
        [_tableView.header endRefreshing];

    }];
    _tableView.header = header;
 
    
    MJRefreshFooter *footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        _count +=10;
        [self loadData];
    }];
    _tableView.footer = footer;
    
    //页面加载时第一次刷新
    [_tableView.header beginRefreshing];
}
-(void)loadData
{
    NSString *str = [NSString stringWithFormat:API_VISUAL,_count];
    [DownloadManager GET:str success:^(id obj) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:obj   options:NSJSONReadingMutableContainers error:nil];
        _btnModelsArray = [VisualSidModel arrayOfModelsFromDictionaries:dict[@"videoSidList"]];
        NSArray *array = [VideoModel arrayOfModelsFromDictionaries:dict[@"videoList"]];
        if(_count == 0){
            [_dataArray setArray:array];
            [_tableView.header endRefreshing];
        }
        else{
            [_dataArray addObjectsFromArray:array];
            [_tableView.footer endRefreshing];
        }
        [_tableView reloadData];
    }];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //第一个单元格
    if(indexPath.row == 0){
        static NSString *cellId = @"topcell";
        VisualSidCell *sidCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!sidCell){
            sidCell = [[VisualSidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        sidCell.modelArray = _btnModelsArray;
        return sidCell;
    }
    else
    {
        static NSString *cellId = @"cell";
        VisualVideoCell *sidCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!sidCell){
            sidCell = [[VisualVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        sidCell.model = _dataArray[indexPath.row-1];
        return sidCell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return WIDTH/4+5;
    }
    else{
        return WIDTH*0.618+79;
    }
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
