//
//  MusicViewController.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/10.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "MusicViewController.h"
#import "Mp3ListModel.h"
#import "Mp3Model.h"
#import "Mp3Cell.h"
#import "Mp3PlayerTool.h"
@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UIImageView *_bgView;
    UIButton *_playBtn;//播放按钮，需要修改图片
    UIImageView *_cover;//旋转
    NSArray *_playImgArray;//播放按钮要替换

    UITableView *_tableView;//播放标题
    NSMutableArray *_dataArray;//
    int _count;//请求数
    
    UISlider *_timeSlider;//进度条
    UILabel *_startTime;
    UILabel *_endTime;
    
    BOOL _isPlaying;

}
@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtnWithImage:@"icon_back_highlighted"];
    [self setMiddleTitle:self.model.tname];
    [self creatMusicUI];
}

- (void)creatMusicUI
{
    //背景图
    [self creatbg];
    //封面
    [self creatCover];
    //按钮
    [self creatBtns];
    //播放列表
    [self creatTableView];
    //滑块
    [self creatTimeSlider];
}
- (void)creatbg
{
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
    [bgImg setImage:[UIImage imageNamed:@"usercenter_hd_cover_3"]];
    [self.view addSubview:bgImg];
    [self.view sendSubviewToBack:bgImg];
    bgImg.userInteractionEnabled = YES;
    _bgView = bgImg;
}
- (void)creatCover
{
    float width = WIDTH/2.5;
    UIImageView *cover = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    cover.center = CGPointMake(WIDTH/2, NAVHEIGHT+20+width/2);
    cover.layer.borderWidth = 5;
    cover.layer.borderColor = [UIColor brownColor].CGColor;
    cover.layer.cornerRadius = width/2;
    cover.clipsToBounds = YES;
    [cover sd_setImageWithURL:[NSURL URLWithString:self.model.radio.imgsrc]];
    
    cover.contentMode = UIViewContentModeScaleAspectFill;
    [_bgView addSubview:cover];
    _cover = cover;
}
- (void)creatBtns
{
    _playImgArray = @[@"audionews_play_button",@"audionews_pause_button"];
    
    for (int i=0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        btn.tag = 100+i;
        NSString *imgName;
        if(i==0){
           
           imgName = @"上一曲.tiff";
        }
        else if (i==1){
            imgName = _playImgArray[0];
            _playBtn = btn;
        }
        else{
            imgName = @"下一曲.tiff";
        }
        btn.center = CGPointMake(WIDTH/6+i*WIDTH/3,_cover.center.y);
        [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(musicBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:btn];
    }
}
- (void)creatTimeSlider
{
    _timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_bgView.frame)-70,  WIDTH-20,20)];
    _timeSlider.minimumTrackTintColor = [UIColor whiteColor];
    [_timeSlider setThumbImage:[UIImage imageNamed:@"slider-handle"] forState:UIControlStateNormal];
    [self.view addSubview:_timeSlider];
    
    _startTime = [[UILabel alloc]initWithFrame:CGRectMake( CGRectGetMinX(_timeSlider.frame),CGRectGetMaxY(_timeSlider.frame),50,20)];
    _startTime.textColor = [UIColor whiteColor];
    _startTime.text = @"00:00";
    [self.view addSubview:_startTime];
    
    _endTime = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_timeSlider.frame)-50, CGRectGetMinY(_startTime.frame), 50, 20)];
    _endTime.textColor = [UIColor whiteColor];
    [self.view addSubview:_endTime];
}
- (void)creatTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgView.frame), WIDTH, HEIGHT-CGRectGetMaxY(_bgView.frame)-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    

    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _count = 20;
        [self loadData];
       

    }];
    [_tableView.header beginRefreshing];
    
    _tableView.footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        _count+= 20;
        [self loadData];
    }];
}


- (void)loadData
{
    NSString *str = [NSString stringWithFormat:API_MUSIC,self.model.tid,_count];
    [DownloadManager GET:str success:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _dataArray = [Mp3ListModel arrayOfModelsFromDictionaries: dict [self.model.tid]];
        [_tableView.header endRefreshing];
        [_tableView reloadData];
        //第一次头部刷新
        if(_count == 20){
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            [_tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            Mp3ListModel *model = _dataArray[0];
            [self playWithMp3Id:model.docid];
        }
    }];
}
- (void)musicBtnPressed:(UIButton *)btn
{
    NSInteger index = btn.tag - 100;
    switch (index) {
        case 0:
            break;
        
        case 1:
            [self stopControl];
            break;
        case 2:
            break;
        default:
            break;
    }
}
#pragma mark 音乐控制
- (void)playWithMp3Id:(NSString *)mp3Id
{
    NSString *str = [NSString stringWithFormat:API_MP3,mp3Id];
    [DownloadManager GET:str success:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict2 = dict[mp3Id][@"video"][0];
        Mp3Model *mp3model = [[Mp3Model alloc]initWithDictionary:dict2 error:nil];
        //根据链接创建
        Mp3PlayerTool *tool = [Mp3PlayerTool sharedMp3PlayerTool];
        [tool startToPlayMusic:mp3model.url_m3u8];
        _isPlaying = YES;
        [_playBtn setImage:[UIImage imageNamed:_playImgArray[1]] forState:UIControlStateNormal];
    }];
    
}
- (void)stopControl
{
    
    Mp3PlayerTool *tool = [Mp3PlayerTool sharedMp3PlayerTool];
    if(_isPlaying == YES){
        _isPlaying = NO;
        [tool pause];
        [_playBtn setImage:[UIImage imageNamed:_playImgArray[0]] forState:UIControlStateNormal];
    }
    else{
        _isPlaying = YES;
        [tool continueToPlay];
        [_playBtn setImage:[UIImage imageNamed:_playImgArray[1]] forState:UIControlStateNormal];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    Mp3Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell == nil){
        cell = [[Mp3Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
//单元格被选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     Mp3ListModel *model = _dataArray[indexPath.row];
    [self playWithMp3Id:model.docid];
//    static NSString *cellId = @"cell";
//    Mp3Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    [cell ];
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
