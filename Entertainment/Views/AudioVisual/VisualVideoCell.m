//
//  VisualVideoCell.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/3.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "VisualVideoCell.h"
#import <AVKit/AVKit.h>
@interface VisualVideoCell()<AVPlayerViewControllerDelegate>
@property (nonatomic,strong)AVPlayerViewController *avPlayerVc;
@end
@implementation VisualVideoCell

{
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
    UIImageView *_imageView;
    UIButton *_playBtn;
    UILabel *_timeLabel;
    UILabel *_countLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setSeparatorInset:UIEdgeInsetsZero];
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    float width = WIDTH-10;
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, width, 320.f)];
    [self addSubview:bgView];
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 30)];
    [bgView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:FONTMAXSIZE];
    //副标题
    _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), width, 20)];
    _subTitleLabel.textColor = [UIColor darkGrayColor];
    _subTitleLabel.font = [UIFont systemFontOfSize:FONTMINSIZE];
    [bgView addSubview:_subTitleLabel];
    //图片
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_subTitleLabel.frame)+5, width, width*0.55)];
    _imageView.userInteractionEnabled = YES;
    [bgView addSubview:_imageView];
    //播放按钮
    _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon@2x.png"] forState:UIControlStateNormal];
    _playBtn.center = CGPointMake(CGRectGetWidth(_imageView.frame)/2, CGRectGetHeight(_imageView.frame)/2);
    [_playBtn addTarget:self action:@selector(playBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView addSubview:_playBtn];
    
    
    //最下面一层按钮
    UIView *btnBgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame)+5, width, 40)];
    [bgView addSubview:btnBgView];
    //时间长度
    UIImageView *timeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 20, 20)];
    [timeImageView setImage:[UIImage imageNamed:@"video_list_cell_time@2x.png"]];
    [btnBgView addSubview:timeImageView];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, 40, 20)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor darkGrayColor];
    [btnBgView addSubview:_timeLabel];
    
    //播放次数
    UIImageView *playImageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 10, 20, 20)];
    [playImageView setImage:[UIImage imageNamed:@"video_list_cell_icon@2x.png"]];
    [btnBgView addSubview:playImageView];
    
    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(95.0, 10, 50, 20)];
    _countLabel.font = [UIFont systemFontOfSize:12];
    _countLabel.textColor = [UIColor darkGrayColor];
    [btnBgView addSubview:_countLabel];
    //评论
    UIButton *commentBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-90, 5, 30, 30)];
    
    //边框【根据是否有人评论，自适应，做不了】
//    [commentBtn setBackgroundImage:[UIImage imageNamed:@"night_channel_compact_placeholder_inactive@2x.png"] forState:UIControlStateNormal];
    [commentBtn setBackgroundImage:[UIImage imageNamed:@"video_comment_pen@2x.png"] forState:UIControlStateNormal];
    [btnBgView addSubview:commentBtn];
    //转发
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(width-50, 5.0, 30, 30)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"video_category_share@2x.png"] forState:UIControlStateNormal];
    [btnBgView addSubview:shareBtn];
    //增加分隔
    UIView *last = [[UIView alloc]initWithFrame:CGRectMake(0.0, CGRectGetMaxY(btnBgView.frame), WIDTH, 5)];
    last.backgroundColor = LIGHTCOLOR;
    [self addSubview:last];
}
-(void)setModel:(VideoModel *)model
{
    _model = model;
    _titleLabel.text = model.title;
    _subTitleLabel.text = model.des;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    NSString *timeStr = [NSString stringWithFormat:@"%02ld:%02ld",model.length/60,model.length%60];
    _timeLabel.text = timeStr;
    NSString *playCountStr = [NSString stringWithFormat:@"%.1lf万",model.playCount/10000.0];
    _countLabel.text = playCountStr;
    
    [self creatPlayer];
    
}

//需要url
- (void)creatPlayer
{
    if (_avPlayerVc == nil) {
        _avPlayerVc = [[AVPlayerViewController alloc]init];
    }
    
    _avPlayerVc.player =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:self.model.mp4_url]];
    _avPlayerVc.videoGravity = AVLayerVideoGravityResizeAspect;
    _avPlayerVc.delegate = self;
    _avPlayerVc.showsPlaybackControls = YES;
    _avPlayerVc.view.frame = _imageView.bounds;
    _avPlayerVc.view.hidden = YES;
    [_imageView addSubview:_avPlayerVc.view];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:_avPlayerVc.player.currentItem];
    
}
- (void)playBtnPressed:(UIButton *)btn
{
    
    _avPlayerVc.view.hidden = NO;
    
    [_avPlayerVc.player play];
    
    
}
- (void)didPlayEnd
{
    NSLog(@"..did stop.");
    //跳转到开头
    [_avPlayerVc.player.currentItem seekToTime:kCMTimeZero];
    _avPlayerVc.view.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
