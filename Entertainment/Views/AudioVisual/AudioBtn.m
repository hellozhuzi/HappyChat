//
//  audioBtn.m
//  网易新闻测试
//
//  Created by zhufengzhu on 16/3/9.
//  Copyright © 2016年 zhufengzhu. All rights reserved.
//

#import "AudioBtn.h"

@implementation AudioBtn
{
    UIImageView *_photo;
    UIImageView *_play;
    UILabel *_name;
    UILabel *_des;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self creatUI];
    }
    return  self;
}
- (void)creatUI
{
    float width = self.frame.size.width;
    _photo = [[UIImageView alloc]initWithFrame:CGRectMake(7.5, 10, width-15, width-15)];
    //半径
    [_photo.layer setCornerRadius:CGRectGetWidth(_photo.frame)/2];
    [_photo setClipsToBounds:YES];
    _photo.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_photo];
    
    _play = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    _play.center = CGPointMake(CGRectGetWidth(_photo.frame)/2, CGRectGetHeight(_photo.frame)/2);
    [_play setImage:[UIImage imageNamed:@"video_list_cell_big_icon@2x.png"]];
    [_photo addSubview:_play];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_photo.frame)+5, width-10, 20)];
    _name.font = [UIFont systemFontOfSize:15];
    _name.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_name];
    
    _des = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_name.frame)+5, width-10, 40)];
    _des.textColor = [UIColor darkGrayColor];
    _des.font = [UIFont systemFontOfSize:12];
    _des.numberOfLines = 2;
    [self addSubview:_des];
    
    //响应
    [self addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)setModel:(AudioSmallModel *)model
{
    _model = model;
    [_photo sd_setImageWithURL:[NSURL URLWithString:model.radio.imgsrc]];
    _name.text = model.tname;
    _des.text = model.radio.title;
}

//按钮转到其他页面
-(void)btnPressed:(UIButton *)btn
{
    //发送通知
    NSNotification *notification = [NSNotification notificationWithName:@"mp3" object:self.model];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
