//
//  RecommendReadViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/2/29.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "RecommendReadViewController.h"
#import "MJRefresh.h"
#import "ReadModel.h"
#import "ReadTableViewCell.h"
#import "ReadMorePicsTableViewCell.h"
#import "ReadDetailViewController.h"
@interface RecommendReadViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_readArray;
    UITableView *_tableView;
    NSInteger _count;
    BOOL _isLoaded;
    
}
@end

@implementation RecommendReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    _readArray = [NSMutableArray array];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self creatTableView];
    [self refreshData];
   
}
-(void)creatTableView
{
    CGRect rect = self.view.bounds;
    rect.size.height -= 64+49;
    
    _tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];

    [self.view  addSubview:_tableView];
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _count = 20;
        [self loadData];
    }];
    _tableView.header = header;
}

-(void)loadData
{
    NSString *str = [NSString stringWithFormat:_url,_count];
    [DownloadManager GET:str success:^(NSData *data) {
    
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [ReadModel arrayOfModelsFromDictionaries:dict[@"推荐"]];
        for (ReadModel *model in array) {
            [_readArray insertObject:model atIndex:0];
        }
        
        [_tableView.header endRefreshing];
        [_tableView reloadData];
    }];
}
#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _readArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadModel *model = _readArray[indexPath.row];
    if([model.template containsString:@"pic3"]){
        static NSString *cellId = @"pics";
        ReadMorePicsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            cell = [[ReadMorePicsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = model;
        return cell;
    }
    else
    {
    
        static NSString *cellId = @"cellID";
        ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell){
            cell = [[ReadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = model;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadModel *model = _readArray[indexPath.row];
    return [model cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到新闻页面
    ReadModel *model = _readArray[indexPath.row];
    ReadDetailViewController *rdVC = [[ReadDetailViewController alloc]init];
    rdVC.url = [NSString stringWithFormat:API_DETAIL,model.replyid];
    self.vcDelegate.hidesBottomBarWhenPushed = YES;
    [self.navDelegate pushViewController:rdVC animated:YES];
    self.vcDelegate.hidesBottomBarWhenPushed = NO;
}
-(void)refreshData
{
    if(!_isLoaded){
        [_tableView.header beginRefreshing];
        _isLoaded = YES;
    }
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
